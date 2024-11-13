//
//  DrvOrderDetail.swift
//  Speedo
//
//  Created by mac on 24/05/21.
//

import Foundation


struct ApiDrvOrderDetail : Codable {
    
    let message : String?
    let result : ResDrvOrderDetail?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResDrvOrderDetail.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResDrvOrderDetail : Codable {
    
    let acceptDriverId : String?
    let addressDetails : ResAddressDetail?
    let addressId : String?
    let adminComFee : String?
    let cartDetails : [ResCartDetail]?
    let cartId : String?
    let companyId : String?
    let date : String?
    let dateTime : String?
    let deliveryCharge : String?
    let deliveryDate : String?
    let deliveryFee : String?
    let deliveryStatus : String?
    let deliveryTime : String?
    let deliveryType : String?
    let discountAmt : String?
    let driverDelFee : String?
    let driverDetails : ResDriverDetail?
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
        case deliveryCharge = "delivery_charge"
        case deliveryDate = "delivery_date"
        case deliveryFee = "delivery_fee"
        case deliveryStatus = "delivery_status"
        case deliveryTime = "delivery_time"
        case deliveryType = "delivery_type"
        case discountAmt = "discount_amt"
        case driverDelFee = "driver_del_fee"
        case driverDetails = "driver_details"
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
        deliveryCharge = try values.decodeIfPresent(String.self, forKey: .deliveryCharge)
        deliveryDate = try values.decodeIfPresent(String.self, forKey: .deliveryDate)
        deliveryFee = try values.decodeIfPresent(String.self, forKey: .deliveryFee)
        deliveryStatus = try values.decodeIfPresent(String.self, forKey: .deliveryStatus)
        deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
        deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
        discountAmt = try values.decodeIfPresent(String.self, forKey: .discountAmt)
        driverDelFee = try values.decodeIfPresent(String.self, forKey: .driverDelFee)
        driverDetails = try values.decodeIfPresent(ResDriverDetail.self, forKey: .driverDetails)
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


struct ResDriverDetail : Codable {
    
    let aboutMe : String?
    let address : String?
    let areaId : String?
    let availableStatus : String?
    let businessType : String?
    let cityId : String?
    let closeTime : String?
    let code : String?
    let countryId : String?
    let dateTime : String?
    let email : String?
    let expDate : String?
    let firstName : String?
    let gST : String?
    let id : String?
    let image : String?
    let iosRegisterId : String?
    let lastName : String?
    let lat : String?
    let licenceImage : String?
    let lon : String?
    let mobile : String?
    let openTime : String?
    let password : String?
    let planId : String?
    let regNumber : String?
    let registerId : String?
    let registrationImage : String?
    let registrationNo : String?
    let restCatId : String?
    let restCatName : String?
    let restCoverImage : String?
    let restImage : String?
    let restName : String?
    let socialId : String?
    let stateId : String?
    let status : String?
    let tinNumber : String?
    let totalDeliveries : String?
    let type : String?
    let vehicleId : String?
    let vehicleImage : String?
    let vehicleInsuraImage : String?
    let wallet : String?
    
    enum CodingKeys: String, CodingKey {
        case aboutMe = "about_me"
        case address = "address"
        case areaId = "area_id"
        case availableStatus = "available_status"
        case businessType = "business_type"
        case cityId = "city_id"
        case closeTime = "close_time"
        case code = "code"
        case countryId = "country_id"
        case dateTime = "date_time"
        case email = "email"
        case expDate = "exp_date"
        case firstName = "first_name"
        case gST = "GST"
        case id = "id"
        case image = "image"
        case iosRegisterId = "ios_register_id"
        case lastName = "last_name"
        case lat = "lat"
        case licenceImage = "licence_image"
        case lon = "lon"
        case mobile = "mobile"
        case openTime = "open_time"
        case password = "password"
        case planId = "plan_id"
        case regNumber = "reg_number"
        case registerId = "register_id"
        case registrationImage = "registration_image"
        case registrationNo = "registration_no"
        case restCatId = "rest_cat_id"
        case restCatName = "rest_cat_name"
        case restCoverImage = "rest_cover_image"
        case restImage = "rest_image"
        case restName = "rest_name"
        case socialId = "social_id"
        case stateId = "state_id"
        case status = "status"
        case tinNumber = "tin_number"
        case totalDeliveries = "total_deliveries"
        case type = "type"
        case vehicleId = "vehicle_id"
        case vehicleImage = "vehicle_image"
        case vehicleInsuraImage = "vehicle_insura_image"
        case wallet = "wallet"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aboutMe = try values.decodeIfPresent(String.self, forKey: .aboutMe)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        areaId = try values.decodeIfPresent(String.self, forKey: .areaId)
        availableStatus = try values.decodeIfPresent(String.self, forKey: .availableStatus)
        businessType = try values.decodeIfPresent(String.self, forKey: .businessType)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        closeTime = try values.decodeIfPresent(String.self, forKey: .closeTime)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        expDate = try values.decodeIfPresent(String.self, forKey: .expDate)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        gST = try values.decodeIfPresent(String.self, forKey: .gST)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        iosRegisterId = try values.decodeIfPresent(String.self, forKey: .iosRegisterId)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        licenceImage = try values.decodeIfPresent(String.self, forKey: .licenceImage)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        openTime = try values.decodeIfPresent(String.self, forKey: .openTime)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        planId = try values.decodeIfPresent(String.self, forKey: .planId)
        regNumber = try values.decodeIfPresent(String.self, forKey: .regNumber)
        registerId = try values.decodeIfPresent(String.self, forKey: .registerId)
        registrationImage = try values.decodeIfPresent(String.self, forKey: .registrationImage)
        registrationNo = try values.decodeIfPresent(String.self, forKey: .registrationNo)
        restCatId = try values.decodeIfPresent(String.self, forKey: .restCatId)
        restCatName = try values.decodeIfPresent(String.self, forKey: .restCatName)
        restCoverImage = try values.decodeIfPresent(String.self, forKey: .restCoverImage)
        restImage = try values.decodeIfPresent(String.self, forKey: .restImage)
        restName = try values.decodeIfPresent(String.self, forKey: .restName)
        socialId = try values.decodeIfPresent(String.self, forKey: .socialId)
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tinNumber = try values.decodeIfPresent(String.self, forKey: .tinNumber)
        totalDeliveries = try values.decodeIfPresent(String.self, forKey: .totalDeliveries)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
        vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
        vehicleInsuraImage = try values.decodeIfPresent(String.self, forKey: .vehicleInsuraImage)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
    }
}
