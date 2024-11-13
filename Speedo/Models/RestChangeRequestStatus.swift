//
//  RestChangeRequestStatus.swift
//  Speedo
//
//  Created by mac on 25/05/21.
//

import Foundation

struct ApiRestChangeStatus : Codable {
    
    let message : String?
    let result : ResRestChangeStatus?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResRestChangeStatus.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResRestChangeStatus : Codable {
    
    let acceptDriverId : String?
    let addressId : String?
    let cartId : String?
    let companyId : String?
    let dateTime : String?
    let deliveryCharge : String?
    let deliveryDate : String?
    let deliveryStatus : String?
    let deliveryTime : String?
    let driverId : String?
    let id : String?
    let orderId : String?
    let paymentMethod : String?
    let paymentStatus : String?
    let removeStatus : String?
    let status : String?
    let totalAmount : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case acceptDriverId = "accept_driver_id"
        case addressId = "address_id"
        case cartId = "cart_id"
        case companyId = "company_id"
        case dateTime = "date_time"
        case deliveryCharge = "delivery_charge"
        case deliveryDate = "delivery_date"
        case deliveryStatus = "delivery_status"
        case deliveryTime = "delivery_time"
        case driverId = "driver_id"
        case id = "id"
        case orderId = "order_id"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case removeStatus = "remove_status"
        case status = "status"
        case totalAmount = "total_amount"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        acceptDriverId = try values.decodeIfPresent(String.self, forKey: .acceptDriverId)
        addressId = try values.decodeIfPresent(String.self, forKey: .addressId)
        cartId = try values.decodeIfPresent(String.self, forKey: .cartId)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        deliveryCharge = try values.decodeIfPresent(String.self, forKey: .deliveryCharge)
        deliveryDate = try values.decodeIfPresent(String.self, forKey: .deliveryDate)
        deliveryStatus = try values.decodeIfPresent(String.self, forKey: .deliveryStatus)
        deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
        driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
}
