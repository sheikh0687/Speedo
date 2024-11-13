//
//  Basic.swift
//  Speedo
//
//  Created by mac on 21/05/21.
//

import Foundation

struct ApiBasic : Codable {
    
    let message : String?
    let result : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
