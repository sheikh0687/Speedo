//
//  Order.swift
//  Speedo
//
//  Created by mac on 18/06/21.
//

import Foundation

struct ApiOrders : Codable {
    
    let message : String?
    let result : [ResOrders]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResOrders].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct ResOrders : Codable {
    
    let acceptDriverId : String?
    let addressDetails : ResAddressDetail?
    let addressId : String?
    let cartDetails : [ResCartDetail]?
    let sub_total : String?
    let delivery_fee : String?
    let discount_amt : String?
    let cartId : String?
    let companyId : String?
    let dateTime : String?
    let deliveryCharge : String?
    let deliveryDate : String?
    let deliveryStatus : String?
    let deliveryTime : String?
    let driverId : String?
    let driverRatingReview : String?
    let date : String?
    let id : String?
    let orderId : String?
    let orderReadyTime : String?
    let paymentMethod : String?
    let paymentStatus : String?
    let productDetails : [ResProductDetail]?
    let removeStatus : String?
    let restDetails : ResRestDetail?
    let restRatingReview : String?
    let status : String?
    let totalAmount : String?
    let time : String?
    let userId : String?
    let orderType: String?
    let delivery_type: String?
    
    enum CodingKeys: String, CodingKey {
        case acceptDriverId = "accept_driver_id"
        case addressDetails = "address_details"
        case addressId = "address_id"
        case cartDetails = "cart_details"
        case sub_total = "sub_total"
        case delivery_fee = "delivery_fee"
        case discount_amt = "discount_amt"
        case cartId = "cart_id"
        case companyId = "company_id"
        case dateTime = "date_time"
        case deliveryCharge = "delivery_charge"
        case deliveryDate = "delivery_date"
        case deliveryStatus = "delivery_status"
        case deliveryTime = "delivery_time"
        case driverId = "driver_id"
        case driverRatingReview = "driver_rating_review"
        case id = "id"
        case orderId = "order_id"
        case orderReadyTime = "order_ready_time"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case productDetails = "product_details"
        case removeStatus = "remove_status"
        case restDetails = "rest_details"
        case restRatingReview = "rest_rating_review"
        case status = "status"
        case totalAmount = "total_amount"
        case userId = "user_id"
        case orderType = "order_type"
        case delivery_type = "delivery_type"
        case date = "date"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        acceptDriverId = try values.decodeIfPresent(String.self, forKey: .acceptDriverId)
        addressDetails = try values.decodeIfPresent(ResAddressDetail.self, forKey: .addressDetails)
        addressId = try values.decodeIfPresent(String.self, forKey: .addressId)
        cartDetails = try values.decodeIfPresent([ResCartDetail].self, forKey: .cartDetails)
        cartId = try values.decodeIfPresent(String.self, forKey: .cartId)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        deliveryCharge = try values.decodeIfPresent(String.self, forKey: .deliveryCharge)
        deliveryDate = try values.decodeIfPresent(String.self, forKey: .deliveryDate)
        deliveryStatus = try values.decodeIfPresent(String.self, forKey: .deliveryStatus)
        deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
        driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
        driverRatingReview = try values.decodeIfPresent(String.self, forKey: .driverRatingReview)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        orderReadyTime = try values.decodeIfPresent(String.self, forKey: .orderReadyTime)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
        productDetails = try values.decodeIfPresent([ResProductDetail].self, forKey: .productDetails)
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        restDetails = try values.decodeIfPresent(ResRestDetail.self, forKey: .restDetails)
        restRatingReview = try values.decodeIfPresent(String.self, forKey: .restRatingReview)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        orderType = try values.decodeIfPresent(String.self, forKey: .orderType)
        delivery_type = try values.decodeIfPresent(String.self, forKey: .delivery_type)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
        delivery_fee = try values.decodeIfPresent(String.self, forKey: .delivery_fee)
        discount_amt = try values.decodeIfPresent(String.self, forKey: .discount_amt)
    }
}
