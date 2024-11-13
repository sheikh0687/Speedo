//
//  Earning.swift
//  Speedo
//
//  Created by mac on 28/07/21.
//

import Foundation

struct ApiDriverEarning : Codable {
    
    let driver_total_earning : String?
    let driver_total_earning_today : String?
    let driver_total_earning_week : String?
    let driver_total_earning_month : String?
    let driver_total_earning_year : String?
    let result : [ResOrders]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case driver_total_earning = "Driver_total_earning"
        case driver_total_earning_today = "Driver_total_earning_today"
        case driver_total_earning_week = "Driver_total_earning_week"
        case driver_total_earning_month = "Driver_total_earning_month"
        case driver_total_earning_year = "Driver_total_earning_year"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        driver_total_earning = try values.decodeIfPresent(String.self, forKey: .driver_total_earning)
        driver_total_earning_today = try values.decodeIfPresent(String.self, forKey: .driver_total_earning_today)
        driver_total_earning_week = try values.decodeIfPresent(String.self, forKey: .driver_total_earning_week)
        driver_total_earning_month = try values.decodeIfPresent(String.self, forKey: .driver_total_earning_month)
        driver_total_earning_year = try values.decodeIfPresent(String.self, forKey: .driver_total_earning_year)
        result = try values.decodeIfPresent([ResOrders].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}


struct ApiEarnings : Codable {
    
    let message : String?
    let restTotalEarning : String?
    let result : [ResOrders]?
    let status : String?
    let total_earning_today : String?
    let total_earning_weekly : String?
    let total_earning_monthly : String?
    let total_earning_yearly : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case restTotalEarning = "Rest_total_earning"
        case result = "result"
        case status = "status"
        case total_earning_today = "total_earning_today"
        case total_earning_weekly = "total_earning_weekly"
        case total_earning_monthly = "total_earning_monthly"
        case total_earning_yearly = "total_earning_yearly"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        restTotalEarning = try values.decodeIfPresent(String.self, forKey: .restTotalEarning)
        result = try values.decodeIfPresent([ResOrders].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        total_earning_today = try values.decodeIfPresent(String.self, forKey: .total_earning_today)
        total_earning_weekly = try values.decodeIfPresent(String.self, forKey: .total_earning_weekly)
        total_earning_monthly = try values.decodeIfPresent(String.self, forKey: .total_earning_monthly)
        total_earning_yearly = try values.decodeIfPresent(String.self, forKey: .total_earning_yearly)
    }
    
}
