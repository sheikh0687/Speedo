//
//  RestOfferList.swift
//  Speedo
//
//  Created by mac on 03/08/21.
//

import Foundation

struct ApiRestOfferList : Codable {
    
    let message : String?
    let result : [ResRestOfferList]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResRestOfferList].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct ResRestOfferList : Codable {
    
    let catId : String?
    let dateTime : String?
    let descriptionField : String?
    let endTime : String?
    let expDate : String?
    let id : String?
    let image : String?
    let offerCode : String?
    let percentage : String?
    let restId : String?
    let startTime : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case catId = "cat_id"
        case dateTime = "date_time"
        case descriptionField = "description"
        case endTime = "end_time"
        case expDate = "exp_date"
        case id = "id"
        case image = "image"
        case offerCode = "offer_code"
        case percentage = "percentage"
        case restId = "rest_id"
        case startTime = "start_time"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        catId = try values.decodeIfPresent(String.self, forKey: .catId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        expDate = try values.decodeIfPresent(String.self, forKey: .expDate)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        offerCode = try values.decodeIfPresent(String.self, forKey: .offerCode)
        percentage = try values.decodeIfPresent(String.self, forKey: .percentage)
        restId = try values.decodeIfPresent(String.self, forKey: .restId)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
