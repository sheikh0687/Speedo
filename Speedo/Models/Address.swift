//
//  Address.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import Foundation

struct ApiAddress : Codable {
    
    let message : String?
    let result : [ResAddress]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResAddress].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct ResAddress : Codable {
    
    let address : String?
    let city : String?
    let id : String?
    let lat : String?
    let lon : String?
    let postalCode : String?
    let title : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case city = "city"
        case id = "id"
        case lat = "lat"
        case lon = "lon"
        case postalCode = "postal_code"
        case title = "title"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}
