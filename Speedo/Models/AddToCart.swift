//
//  AddToCart.swift
//  Speedo
//
//  Created by mac on 20/05/21.
//

import Foundation

struct ApiAddToCart : Codable {
    
    let message : String?
    let quantity : String?
    let result : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case quantity = "quantity"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
