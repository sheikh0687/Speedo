//
//  OTP.swift
//  Speedo
//
//  Created by mac on 05/03/22.
//

import Foundation

struct ApiOtpForSignUp : Codable {
    
    let message : String?
    let result : ResOtp?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResOtp.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResOtp : Codable {
    
    let code : Int?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }
    
}
