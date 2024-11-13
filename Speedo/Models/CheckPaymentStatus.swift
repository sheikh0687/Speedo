//
//  CheckPaymentStatus.swift
//  Speedo
//
//  Created by mac on 16/11/21.
//

import Foundation

struct ApiCheckPaymentStatus : Codable {
    
    let message : String?
    let result : ResCheckPayment?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResCheckPayment.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct ResCheckPayment : Codable {
    
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
