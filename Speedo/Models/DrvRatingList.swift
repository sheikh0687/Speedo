//
//  DrvRatingList.swift
//  Speedo
//
//  Created by mac on 24/05/21.
//

import Foundation

struct ApiDrvRatingList : Codable {
    
    let message : String?
    let result : [ResDrvRatingList]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResDrvRatingList].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResDrvRatingList : Codable {
    
    let dateTime : String?
    let driverId : String?
    let id : String?
    let image : String?
    let rating : String?
    let requestId : String?
    let review : String?
    let type : String?
    let userId : String?
    let userName : String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "date_time"
        case driverId = "driver_id"
        case id = "id"
        case image = "image"
        case rating = "rating"
        case requestId = "request_id"
        case review = "review"
        case type = "type"
        case userId = "user_id"
        case userName = "user_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
}

