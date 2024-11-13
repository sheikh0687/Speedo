//
//  ApplyOfferCode.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import Foundation


struct ApiApplyOfferCode : Codable {
    
    let afterDiscount : String?
    let discount : String?
    let message : String?
    let result : String?
    let status : String?
    let totalAmount : String?
    
    enum CodingKeys: String, CodingKey {
        case afterDiscount = "after_discount"
        case discount = "discount"
        case message = "message"
        case result = "result"
        case status = "status"
        case totalAmount = "total_amount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        afterDiscount = try values.decodeIfPresent(String.self, forKey: .afterDiscount)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
    }    
}
