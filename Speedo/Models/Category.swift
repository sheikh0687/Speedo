//
//  Category.swift
//  Speedo
//
//  Created by mac on 18/05/21.
//

import Foundation

struct ApiCategory : Codable {
    
    let message : String?
    let result : [ResCategory]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResCategory].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResCategory : Codable {
    
    let categoryName : String?
    let dateTime : String?
    let id : String?
    let image : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case dateTime = "date_time"
        case id = "id"
        case image = "image"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
