//
//  API.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation
import RxSwift

protocol APIRequest {
    associatedtype Response: Decodable
    associatedtype Option  : Options
    var base    : String     { get }
    var endpoint: String     { get }
    var options : Option?    { get }
}

public typealias APIResponse<T> = (Result<T, Error>) -> Void
public class Client {
    private let baseURL: String = "https://api.pandascore.co/"
    private let token  : String
    private let session: URLSession
    
    public init(_ token: String) {
        self.token = token
        
        session = URLSession(configuration: .default)
    }
    
    internal func send<T>(_ request: T) -> Single<T.Response> where T : APIRequest {
        return Single<T.Response>.create { [unowned self] (observer) -> Disposable in
            let request = self.endpoint(for: request)
            let task = self.session.dataTask(with: request) { data, response, error in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = response! as! HTTPURLResponse
                guard response.statusCode == 200 else {
                    let error = try! decoder.decode(APIError.self, from: data!)
                    print(request.url!)
                    print(error); return
                }
                if let data = data {
                    do {
                        let response = try decoder.decode(T.Response.self, from: data)
                        observer(.success(response))
                    } catch let e {
                        observer(.error(e))
                    }
                } else if let error = error {
                    observer(.error(error))
                }
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    internal func send<T>(_ request: T, completion: @escaping APIResponse<T.Response>) where T : APIRequest {
        let request = self.endpoint(for: request)
        let task = self.session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let response = response! as! HTTPURLResponse
            guard response.statusCode == 200 else {
                let error = try! decoder.decode(APIError.self, from: data!)
                print(request.url!)
                print(error); return
            }
            if let data = data {
                do {
                    let response = try decoder.decode(T.Response.self, from: data)
                    completion(.success(response))
                } catch let e {
                    completion(.failure(e))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    internal func endpoint<T: APIRequest>(for request: T) -> URLRequest {
        var components = URLComponents(string: baseURL + request.endpoint)
        if let options = request.options {
            options.queryParams(components: &components)
        }

        guard let url = components?.url else { fatalError("Bad endpoint!") }
        
        var req = URLRequest(url: url)
        req.httpMethod = "get"
        req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return req
    }
}

struct APIError: Decodable {
    let error: String?
    let message: String?
}
