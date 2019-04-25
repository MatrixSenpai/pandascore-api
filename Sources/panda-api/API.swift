//
//  API.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

/**
 * Sample
 * - Parameters:
 *   - completion: APIResponse containing
 * - SeeAlso: [PandaScore Documentation]()
 */
/**
 * Sample
 * - Parameters:
 *   -
 * - Returns: Emits a single event containing
 * - SeeAlso: [PandaScore Documentation]()
 */
/*
*   - page: The pagination page to return
*   - per_page: The number of items per page
*   - range: A range object. See `GamesForMatchParameterObject`
*   - filter: A filter object. See `GamesForMatchParameterObject`
*   - sort: A sort object. See `GamesForMatchSortObject`
*/

import Foundation
import RxSwift

protocol APIRequest {
    associatedtype Response: Decodable
    associatedtype Option  : Options
    var base    : String     { get }
    var endpoint: String     { get }
    var options : Option?    { get }
}

/// A wrapper of Result<Value, Error>
public typealias APIResponse<T> = (Result<T, Error>) -> Void
/**
 * Client is the root of all requests. It contains two built-in types of making requests
 * - Reactive `Single` events
 * - Completion callbacks
 *
 * A request may have a few different parameters
 * - Page and Per Page
 *   - standard pagination, optional
 * - Filter and Range
 *   - A ParameterObject with optional fields for filtering or applying ranges
 * - Sort
 *   - A SortObject that contains keys to sort by (ascending or decending)
 *
 * Certain requests may also include an `id` parameter. Those will return only a single element.
 *  All other requests return an array of elements
 *
 */
public class Client {
    private let baseURL: String = "https://api.pandascore.co/"
    private let token  : String
    private let session: URLSession
    
    /**
     * Public initializer
     * - Parameter token: The access token to use. Will be passed as an HTTP header
     */
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
