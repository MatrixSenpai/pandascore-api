//
//  Region.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

/**
 Leagues are the top level events. They don't have a date and represent a regular competition. A League is composed of one or several series.
 Some League of Legends leagues are: EU LCS, NA LCS, LCK, etc.
 
 - SeeAlso: [PandaScore Documentation](https://developers.pandascore.co/doc/#section/Introduction/Events-hierarchy)
*/
public struct League: Decodable {
    public let id             : Int
    public let name           : String
    public let slug           : String
    public let game           : Videogame
    
    public let url            : String?
    public let imageURL       : URL?
    public let isLiveSupported: Bool
    
    public let lastModified   : Date?
    
    public let series         : [BaseSerie]
    
    public var supported: SupportedLeague? { return SupportedLeague(rawValue: id) }
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, url, series
        case imageURL        = "image_url"
        case isLiveSupported = "live_supported"
        case lastModified    = "modified_at"
        case game            = "videogame"
    }
}

public struct BaseLeague: Decodable {
    public let id: Int
    public let image_url: URL?
    public let live_supported: Bool
    public let modified_at: Date?
    public let name: String
    public let slug: String
    public let url: String?
}
