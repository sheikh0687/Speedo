//
//  UserProfile.swift
//  Speedo
//
//  Created by mac on 18/05/21.
//

import Foundation

struct ApiProfile : Codable {
    
    let message : String?
    let result : ResProfile?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResProfile.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResProfile : Codable {
    
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
    let lastName : String?
    let lat : String?
    let licenceImage : String?
    let lon : String?
    let mobile : String?
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
    let stateId : String?
    let status : String?
    let tinNumber : String?
    let totalDeliveries : String?
    let type : String?
    let vehicleId : String?
    let vehicleImage : String?
    let vehicleInsuraImage : String?
    let wallet : String?
    let terms_condition : String?
    let terms_condition_sp : String?
    
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
        case lastName = "last_name"
        case lat = "lat"
        case licenceImage = "licence_image"
        case lon = "lon"
        case mobile = "mobile"
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
        case stateId = "state_id"
        case status = "status"
        case tinNumber = "tin_number"
        case totalDeliveries = "total_deliveries"
        case type = "type"
        case vehicleId = "vehicle_id"
        case vehicleImage = "vehicle_image"
        case vehicleInsuraImage = "vehicle_insura_image"
        case wallet = "wallet"
        case terms_condition = "terms_condition"
        case terms_condition_sp = "terms_condition_sp"
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
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        licenceImage = try values.decodeIfPresent(String.self, forKey: .licenceImage)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
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
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tinNumber = try values.decodeIfPresent(String.self, forKey: .tinNumber)
        totalDeliveries = try values.decodeIfPresent(String.self, forKey: .totalDeliveries)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
        vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
        vehicleInsuraImage = try values.decodeIfPresent(String.self, forKey: .vehicleInsuraImage)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        terms_condition = try values.decodeIfPresent(String.self, forKey: .terms_condition)
        terms_condition_sp = try values.decodeIfPresent(String.self, forKey: .terms_condition_sp)
    }    
}
