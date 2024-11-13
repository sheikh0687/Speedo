//
//  AddAddress.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import Foundation

struct ApiAddAddress : Codable {
    
    let message : String?
    let result : ResAddress?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResAddress.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
