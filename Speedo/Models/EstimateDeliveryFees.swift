//
//  EstimateDeliveryFees.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import Foundation

struct ApiEstimateDeliveryFees : Codable {
    
    let distance : String?
    let driverFareByAdmin : String?
    let estimateTime : Int?
    let fare : String?
    let message : String?
    let result : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case distance = "distance"
        case driverFareByAdmin = "driver_fare_by_admin"
        case estimateTime = "estimate_time"
        case fare = "fare"
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        driverFareByAdmin = try values.decodeIfPresent(String.self, forKey: .driverFareByAdmin)
        estimateTime = try values.decodeIfPresent(Int.self, forKey: .estimateTime)
        fare = try values.decodeIfPresent(String.self, forKey: .fare)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
