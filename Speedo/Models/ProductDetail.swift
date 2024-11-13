//
//  ProductDetail.swift
//  Speedo
//
//  Created by mac on 17/06/21.
//

import Foundation

struct ApiProductDetail : Codable {
    
    let message : String?
    let result : ResUserProductDetail?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(ResUserProductDetail.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResUserProductDetail : Codable {
    
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
    let productLike : String?
    let productSize : [ResProductSize]?
    let removeStatus : String?
    let restId : String?
    let salePrice : String?
    let stock : String?
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
        case productLike = "product_like"
        case productSize = "product_size"
        case removeStatus = "remove_status"
        case restId = "rest_id"
        case salePrice = "sale_price"
        case stock = "stock"
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
        productLike = try values.decodeIfPresent(String.self, forKey: .productLike)
        productSize = try values.decodeIfPresent([ResProductSize].self, forKey: .productSize)
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        restId = try values.decodeIfPresent(String.self, forKey: .restId)
        salePrice = try values.decodeIfPresent(String.self, forKey: .salePrice)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
}

struct ResProductSize : Codable {
    
    let calories : String?
    let dateTime : String?
    let id : String?
    let image : String?
    let price : String?
    let productAdditional : [ResProductAdditional]?
    let productId : String?
    let size : String?
    
    enum CodingKeys: String, CodingKey {
        case calories = "calories"
        case dateTime = "date_time"
        case id = "id"
        case image = "image"
        case price = "price"
        case productAdditional = "product_additional"
        case productId = "product_id"
        case size = "size"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        calories = try values.decodeIfPresent(String.self, forKey: .calories)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        productAdditional = try values.decodeIfPresent([ResProductAdditional].self, forKey: .productAdditional)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        size = try values.decodeIfPresent(String.self, forKey: .size)
    }
    
}

struct ResProductAdditional : Codable {
    
    let dateTime : String?
    let id : String?
    let includeInItemPrice : String?
    let itemName : String?
    let itemPrice : String?
    let priceGoDown : String?
    let priceGoOff : String?
    let productId : String?
    let productSizeId : String?
    let singleChoiceItem : String?
    let singleChoiceItem2 : String?
    let singleChoiceItem3 : String?
    let singleChoiceItem4 : String?
    let default_selected : String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "date_time"
        case id = "id"
        case includeInItemPrice = "include_in_item_price"
        case itemName = "item_name"
        case itemPrice = "item_price"
        case priceGoDown = "price_go_down"
        case priceGoOff = "price_go_off"
        case productId = "product_id"
        case productSizeId = "product_size_id"
        case singleChoiceItem = "single_choice_item"
        case singleChoiceItem2 = "single_choice_item2"
        case singleChoiceItem3 = "single_choice_item3"
        case singleChoiceItem4 = "single_choice_item4"
        case default_selected = "default_selected"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        includeInItemPrice = try values.decodeIfPresent(String.self, forKey: .includeInItemPrice)
        itemName = try values.decodeIfPresent(String.self, forKey: .itemName)
        itemPrice = try values.decodeIfPresent(String.self, forKey: .itemPrice)
        priceGoDown = try values.decodeIfPresent(String.self, forKey: .priceGoDown)
        priceGoOff = try values.decodeIfPresent(String.self, forKey: .priceGoOff)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productSizeId = try values.decodeIfPresent(String.self, forKey: .productSizeId)
        singleChoiceItem = try values.decodeIfPresent(String.self, forKey: .singleChoiceItem)
        singleChoiceItem2 = try values.decodeIfPresent(String.self, forKey: .singleChoiceItem2)
        singleChoiceItem3 = try values.decodeIfPresent(String.self, forKey: .singleChoiceItem3)
        singleChoiceItem4 = try values.decodeIfPresent(String.self, forKey: .singleChoiceItem4)
        default_selected = try values.decodeIfPresent(String.self, forKey: .default_selected)
    }
}
