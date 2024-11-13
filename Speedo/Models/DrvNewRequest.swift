//
//  DrvNewRequest.swift
//  Speedo
//
//  Created by mac on 23/05/21.
//

import Foundation

struct ApiDrvNewRequest : Codable {
    
    let message : String?
    let result : [ResDrvNewRequest]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResDrvNewRequest].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResDrvNewRequest : Codable {
    
    let acceptDriverId : String?
    let addressDetails : ResAddressDetail?
    let addressId : String?
    let cartDetails : [ResCartDetail]?
    let cartId : String?
    let companyId : String?
    let dateTime : String?
    let date : String?
    let deliveryCharge : String?
    let deliveryDate : String?
    let deliveryFee : String?
    let deliveryStatus : String?
    let deliveryTime : String?
    let driverId : String?
    let driverDelFee : String?
    let id : String?
    let orderId : String?
    let paymentMethod : String?
    let paymentStatus : String?
    let productDetails : [ResProductDetail]?
    let removeStatus : String?
    let restDetails : ResRestDetail?
    let status : String?
    let totalAmount : String?
    let time : String?
    let userDetails : ResUserDetail?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case acceptDriverId = "accept_driver_id"
        case addressDetails = "address_details"
        case addressId = "address_id"
        case cartDetails = "cart_details"
        case cartId = "cart_id"
        case companyId = "company_id"
        case dateTime = "date_time"
        case date = "date"
        case deliveryCharge = "delivery_charge"
        case deliveryDate = "delivery_date"
        case deliveryFee = "delivery_fee"
        case deliveryStatus = "delivery_status"
        case deliveryTime = "delivery_time"
        case driverId = "driver_id"
        case driverDelFee = "driver_del_fee"
        case id = "id"
        case orderId = "order_id"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case productDetails = "product_details"
        case removeStatus = "remove_status"
        case restDetails = "rest_details"
        case status = "status"
        case totalAmount = "total_amount"
        case time = "time"
        case userDetails = "user_details"
        case userId = "user_id"
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
        deliveryFee = try values.decodeIfPresent(String.self, forKey: .deliveryFee)
        deliveryStatus = try values.decodeIfPresent(String.self, forKey: .deliveryStatus)
        deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
        driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
        driverDelFee = try values.decodeIfPresent(String.self, forKey: .driverDelFee)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
        productDetails = try values.decodeIfPresent([ResProductDetail].self, forKey: .productDetails)
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        restDetails = try values.decodeIfPresent(ResRestDetail.self, forKey: .restDetails)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        userDetails = try values.decodeIfPresent(ResUserDetail.self, forKey: .userDetails)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }
}

struct ResUserDetail : Codable {
    
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

struct ResRestDetail : Codable {
    
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
    let interestedRestId : String?
    let iosRegisterId : String?
    let kmFare : String?
    let lastName : String?
    let lat : String?
    let licenceImage : String?
    let lon : String?
    let mobile : String?
    let netsPaymentKey : String?
    let openDay : String?
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
    let restOpeClossStatus : String?
    let socialId : String?
    let startFee : String?
    let stateId : String?
    let status : String?
    let taxNumber : String?
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
        case interestedRestId = "interested_rest_id"
        case iosRegisterId = "ios_register_id"
        case kmFare = "km_fare"
        case lastName = "last_name"
        case lat = "lat"
        case licenceImage = "licence_image"
        case lon = "lon"
        case mobile = "mobile"
        case netsPaymentKey = "nets_payment_key"
        case openDay = "open_day"
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
        case restOpeClossStatus = "rest_ope_closs_status"
        case socialId = "social_id"
        case startFee = "start_fee"
        case stateId = "state_id"
        case status = "status"
        case taxNumber = "tax_number"
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
        interestedRestId = try values.decodeIfPresent(String.self, forKey: .interestedRestId)
        iosRegisterId = try values.decodeIfPresent(String.self, forKey: .iosRegisterId)
        kmFare = try values.decodeIfPresent(String.self, forKey: .kmFare)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        licenceImage = try values.decodeIfPresent(String.self, forKey: .licenceImage)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        netsPaymentKey = try values.decodeIfPresent(String.self, forKey: .netsPaymentKey)
        openDay = try values.decodeIfPresent(String.self, forKey: .openDay)
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
        restOpeClossStatus = try values.decodeIfPresent(String.self, forKey: .restOpeClossStatus)
        socialId = try values.decodeIfPresent(String.self, forKey: .socialId)
        startFee = try values.decodeIfPresent(String.self, forKey: .startFee)
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        taxNumber = try values.decodeIfPresent(String.self, forKey: .taxNumber)
        tinNumber = try values.decodeIfPresent(String.self, forKey: .tinNumber)
        totalDeliveries = try values.decodeIfPresent(String.self, forKey: .totalDeliveries)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
        vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
        vehicleInsuraImage = try values.decodeIfPresent(String.self, forKey: .vehicleInsuraImage)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
    }
}

struct ResProductDetail : Codable {
    
    let catId : String?
    let catName : String?
    let currency : String?
    let dateTime : String?
    let descriptionField : String?
    let id : String?
    let image : String?
    let itemName : String?
    let itemPrice : String?
    let productImages : [RetProductImage]?
    let quantity : String?
    let removeStatus : String?
    let restId : String?
    let salePrice : String?
    let stock : String?
    let totalAmount : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case catId = "cat_id"
        case catName = "cat_name"
        case currency = "currency"
        case dateTime = "date_time"
        case descriptionField = "description"
        case id = "id"
        case image = "image"
        case itemName = "item_name"
        case itemPrice = "item_price"
        case productImages = "product_images"
        case quantity = "quantity"
        case removeStatus = "remove_status"
        case restId = "rest_id"
        case salePrice = "sale_price"
        case stock = "stock"
        case totalAmount = "total_amount"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        catId = try values.decodeIfPresent(String.self, forKey: .catId)
        catName = try values.decodeIfPresent(String.self, forKey: .catName)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        itemName = try values.decodeIfPresent(String.self, forKey: .itemName)
        itemPrice = try values.decodeIfPresent(String.self, forKey: .itemPrice)
        productImages = try values.decodeIfPresent([RetProductImage].self, forKey: .productImages)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        restId = try values.decodeIfPresent(String.self, forKey: .restId)
        salePrice = try values.decodeIfPresent(String.self, forKey: .salePrice)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
}

struct ResCartDetail : Codable {
    
    let companyId : String?
    let dateTime : String?
    let extraItemId : String?
    let extraItemName : String?
    let extraItemPrice : String?
    let extraItemQty : String?
    let id : String?
    let productId : String?
    let productName : String?
    let quantity : String?
    let sizeId : String?
    let sizeName : String?
    let sizePrice : String?
    let status : String?
    let totalAmount : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case companyId = "company_id"
        case dateTime = "date_time"
        case extraItemId = "extra_item_id"
        case extraItemName = "extra_item_name"
        case extraItemPrice = "extra_item_price"
        case extraItemQty = "extra_item_qty"
        case id = "id"
        case productId = "product_id"
        case productName = "product_name"
        case quantity = "quantity"
        case sizeId = "size_id"
        case sizeName = "size_name"
        case sizePrice = "size_price"
        case status = "status"
        case totalAmount = "total_amount"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        extraItemId = try values.decodeIfPresent(String.self, forKey: .extraItemId)
        extraItemName = try values.decodeIfPresent(String.self, forKey: .extraItemName)
        extraItemPrice = try values.decodeIfPresent(String.self, forKey: .extraItemPrice)
        extraItemQty = try values.decodeIfPresent(String.self, forKey: .extraItemQty)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        sizeId = try values.decodeIfPresent(String.self, forKey: .sizeId)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        sizePrice = try values.decodeIfPresent(String.self, forKey: .sizePrice)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}


struct ResAddressDetail : Codable {
    
    let address : String?
    let id : String?
    let lat : String?
    let lon : String?
    let title : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case id = "id"
        case lat = "lat"
        case lon = "lon"
        case title = "title"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
}
