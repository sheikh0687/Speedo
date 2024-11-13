//
//  PaymentGateway.swift
//  Speedo
//
//  Created by mac on 16/11/21.
//

import Foundation

struct ApiPaymentGateway : Codable {
    
    let hostedPaymentPageUrl : String?
    let paymentId : String?
    
    enum CodingKeys: String, CodingKey {
        case hostedPaymentPageUrl = "hostedPaymentPageUrl"
        case paymentId = "paymentId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hostedPaymentPageUrl = try values.decodeIfPresent(String.self, forKey: .hostedPaymentPageUrl)
        paymentId = try values.decodeIfPresent(String.self, forKey: .paymentId)
    }
    
}
