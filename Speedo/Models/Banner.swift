//
//  Banner.swift
//  Speedo
//
//  Created by mac on 20/05/21.
//

import Foundation

struct ApiBanner : Codable {
    
    let message : String?
    let result : [ResBanner]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResBanner].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResBanner : Codable {
    
    let dateTime : String?
    let id : String?
    let image : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "date_time"
        case id = "id"
        case image = "image"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
}

