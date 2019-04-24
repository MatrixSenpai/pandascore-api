//
//  Options.swift
//  panda-api
//
//  Created by Mason Phillips on 4/23/19.
//

import Foundation

protocol Options {
    associatedtype Range : ParameterObject
    associatedtype Filter: ParameterObject
    associatedtype Sort  : SortObject
    var page    : Int?    { get }
    var per_page: Int?    { get }
    var range   : Range?  { get }
    var filter  : Filter? { get }
    var sort    : Sort?   { get }
}

extension Options {
    func queryParams(components: inout URLComponents?) {
        var params: [URLQueryItem] = []
        
        if let page = page {
            params.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        if let per = per_page {
            params.append(URLQueryItem(name: "per_page", value: "\(per)"))
        }
        if let r = range {
            params += r.serializedParams(.range)
        }
        if let f = filter {
            params += f.serializedParams(.filter)
        }
        if let s = sort {
            params += s.serializedParams()
        }

        components?.queryItems = params
    }
}

struct GenericOptionsObject: Options {
    typealias RangeObject = GenericParameterObject
    typealias FilterObject = GenericParameterObject
    typealias SortObject = GenericSortObject
    var page: Int?
    var per_page: Int?
    var range: RangeObject?
    var filter: FilterObject?
    var sort: SortObject?
}

protocol ParameterObject {}
struct GenericParameterObject: ParameterObject {}

enum ParameterObjectType: String {
    case filter, sort, range
}

extension ParameterObject {
    func serializedParams(_ key: ParameterObjectType) -> [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        var items: [URLQueryItem] = []
        
        for child in mirror.children {
            var inner = ""
            guard let label = child.label else { continue }
            
            if let value = child.value as? [Int] {
                inner = value.map { String($0) }.joined(separator: ",")
            } else if let value = child.value as? Int {
                inner = "\(value)"
            } else if let value = child.value as? Float {
                inner = "\(value)"
            } else if let value = child.value as? Bool {
                inner = String(describing: value)
            } else if let value = child.value as? Date {
                inner = DateFormatter(formatString: "yyyy-MM-dd'T'HH:mm:ssZ").string(from: value)
            } else { continue }
            
            let qi = URLQueryItem(name: "\(key.rawValue)[\(label)]", value: inner)
            items.append(qi)
        }
        
        return items
    }
}

protocol SortObject {
    associatedtype KeyType: RawRepresentable
    var keys: [(KeyType, Bool)]? { get }
}
struct GenericSortObject: SortObject {
    typealias KeyType = GenericSortKey
    var keys: [(KeyType, Bool)]?
    enum GenericSortKey: String { case none }
}

extension SortObject {
    func serializedParams() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        guard let k = keys else { return items }
        let mapped = k.map { $0.1 ? "\($0.0.rawValue)" : "-" + "\($0.0.rawValue)" }.joined(separator: ",")
        
        items.append(URLQueryItem(name: "sort", value: mapped))
        return items
    }
}
