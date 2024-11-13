//
//  GuestProfile.swift
//  Speedo
//
//  Created by mac on 09/05/22.
//

import Foundation

struct ApiGuestProfile : Codable {
    
    let result : ResGuestProfile?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResGuestProfile.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResGuestProfile : Codable {
    
    let id : String?
    let name : String?
    let email : String?
    let password : String?
    let image : String?
    let type : String?
    let distance : String?
    let commision : String?
    let mobile_number : String?
    let date_time : String?
    let delivery_charge : String?
    let start_fee : String?
    let km_fare : String?
    let guest_user_status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case email = "email"
        case password = "password"
        case image = "image"
        case type = "type"
        case distance = "distance"
        case commision = "commision"
        case mobile_number = "mobile_number"
        case date_time = "date_time"
        case delivery_charge = "delivery_charge"
        case start_fee = "start_fee"
        case km_fare = "km_fare"
        case guest_user_status = "guest_user_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        commision = try values.decodeIfPresent(String.self, forKey: .commision)
        mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        delivery_charge = try values.decodeIfPresent(String.self, forKey: .delivery_charge)
        start_fee = try values.decodeIfPresent(String.self, forKey: .start_fee)
        km_fare = try values.decodeIfPresent(String.self, forKey: .km_fare)
        guest_user_status = try values.decodeIfPresent(String.self, forKey: .guest_user_status)
    }

}

