//
//  MyEarnings.swift
//  Speedo
//
//  Created by mac on 19/10/21.
//

import Foundation

struct ApiMyEarning : Codable {
    
    let driverTotalEarning : String?
    let message : String?
    let result : [ResMyEarning]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case driverTotalEarning = "Driver_total_earning"
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        driverTotalEarning = try values.decodeIfPresent(String.self, forKey: .driverTotalEarning)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResMyEarning].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResMyEarning : Codable {
    
    let acceptDriverId : String?
    let addressDetails : ResAddressDetail?
    let addressId : String?
    let adminComFee : String?
    let cartDetails : [ResCartDetail]?
    let cartId : String?
    let companyId : String?
    let date : String?
    let dateTime : String?
    let delKm : String?
    let deliveryCharge : String?
    let deliveryDate : String?
    let deliveryFee : String?
    let deliveryStatus : String?
    let deliveryTime : String?
    let deliveryType : String?
    let discountAmt : String?
    let driverDelFee : String?
    let driverId : String?
    let id : String?
    let orderId : String?
    let orderReadyTime : String?
    let paymentMethod : String?
    let paymentStatus : String?
    let productDetails : [ResProductDetail]?
    let removeStatus : String?
    let restDetails : ResRestDetail?
    let status : String?
    let subTotal : String?
    let time : String?
    let totalAmount : String?
    let userDetails : ResUserDetail?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case acceptDriverId = "accept_driver_id"
        case addressDetails = "address_details"
        case addressId = "address_id"
        case adminComFee = "admin_com_fee"
        case cartDetails = "cart_details"
        case cartId = "cart_id"
        case companyId = "company_id"
        case date = "date"
        case dateTime = "date_time"
        case delKm = "del_km"
        case deliveryCharge = "delivery_charge"
        case deliveryDate = "delivery_date"
        case deliveryFee = "delivery_fee"
        case deliveryStatus = "delivery_status"
        case deliveryTime = "delivery_time"
        case deliveryType = "delivery_type"
        case discountAmt = "discount_amt"
        case driverDelFee = "driver_del_fee"
        case driverId = "driver_id"
        case id = "id"
        case orderId = "order_id"
        case orderReadyTime = "order_ready_time"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case productDetails = "product_details"
        case removeStatus = "remove_status"
        case restDetails = "rest_details"
        case status = "status"
        case subTotal = "sub_total"
        case time = "time"
        case totalAmount = "total_amount"
        case userDetails = "user_details"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        acceptDriverId = try values.decodeIfPresent(String.self, forKey: .acceptDriverId)
        addressDetails = try values.decodeIfPresent(ResAddressDetail.self, forKey: .addressDetails)
        addressId = try values.decodeIfPresent(String.self, forKey: .addressId)
        adminComFee = try values.decodeIfPresent(String.self, forKey: .adminComFee)
        cartDetails = try values.decodeIfPresent([ResCartDetail].self, forKey: .cartDetails)
        cartId = try values.decodeIfPresent(String.self, forKey: .cartId)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        delKm = try values.decodeIfPresent(String.self, forKey: .delKm)
        deliveryCharge = try values.decodeIfPresent(String.self, forKey: .deliveryCharge)
        deliveryDate = try values.decodeIfPresent(String.self, forKey: .deliveryDate)
        deliveryFee = try values.decodeIfPresent(String.self, forKey: .deliveryFee)
        deliveryStatus = try values.decodeIfPresent(String.self, forKey: .deliveryStatus)
        deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
        deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
        discountAmt = try values.decodeIfPresent(String.self, forKey: .discountAmt)
        driverDelFee = try values.decodeIfPresent(String.self, forKey: .driverDelFee)
        driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        orderReadyTime = try values.decodeIfPresent(String.self, forKey: .orderReadyTime)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
        productDetails = try values.decodeIfPresent([ResProductDetail].self, forKey: .productDetails)
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        restDetails = try values.decodeIfPresent(ResRestDetail.self, forKey: .restDetails)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        userDetails = try values.decodeIfPresent(ResUserDetail.self, forKey: .userDetails)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }    
}
