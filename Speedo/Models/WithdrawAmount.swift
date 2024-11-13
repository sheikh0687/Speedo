//
//  WithdrawAmount.swift
//  Speedo
//
//  Created by mac on 19/10/21.
//

import Foundation

struct ApiWithdrawAmount : Codable {
    
    let message : String?
    let result : ResWithdrawAmount?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResWithdrawAmount.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResWithdrawAmount : Codable {
    
    let accountHolderName : String?
    let accountNumber : String?
    let amount : String?
    let branch : String?
    let dateTime : String?
    let descriptionField : String?
    let id : String?
    let ifscCode : String?
    let status : String?
    let type : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case accountHolderName = "account_holder_name"
        case accountNumber = "account_number"
        case amount = "amount"
        case branch = "branch"
        case dateTime = "date_time"
        case descriptionField = "description"
        case id = "id"
        case ifscCode = "ifsc_code"
        case status = "status"
        case type = "type"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        branch = try values.decodeIfPresent(String.self, forKey: .branch)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        ifscCode = try values.decodeIfPresent(String.self, forKey: .ifscCode)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}
