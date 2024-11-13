//
//  GetCart.swift
//  Speedo
//
//  Created by mac on 20/05/21.
//

import Foundation

struct ApiCart : Codable {
    
    let beforeDiscountAmount : String?
    let deliveryFee : String?
    let message : String?
    let result : [ResCart]?
    let status : String?
    let totalAmount : String?
    let totalCart : String?
    let totalDiscountAmount : String?
    
    enum CodingKeys: String, CodingKey {
        case beforeDiscountAmount = "before_discount_amount"
        case deliveryFee = "delivery_fee"
        case message = "message"
        case result = "result"
        case status = "status"
        case totalAmount = "total_amount"
        case totalCart = "total_cart"
        case totalDiscountAmount = "total_discount_amount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        beforeDiscountAmount = try values.decodeIfPresent(String.self, forKey: .beforeDiscountAmount)
        deliveryFee = try values.decodeIfPresent(String.self, forKey: .deliveryFee)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResCart].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        totalCart = try values.decodeIfPresent(String.self, forKey: .totalCart)
        totalDiscountAmount = try values.decodeIfPresent(String.self, forKey: .totalDiscountAmount)
    }
}

struct ResCart : Codable {
    
    let afterDiscountAmount : String?
    let beforeDiscountAmount : String?
    let catId : String?
    let catName : String?
    let companyId : String?
    let dateTime : String?
    let discountAmount : String?
    let extraItemId : String?
    let extraItemName : String?
    let extraItemPrice : String?
    let extraItemQty : String?
    let id : String?
    let offerApplyStatus : String?
    let offerId : String?
    let productDetails : RetProductDetail?
    let productId : String?
    let productName : String?
    let quantity : String?
    let sizeId : String?
    let sizeName : String?
    let sizePrice : String?
    let status : String?
    let totalAmount : String?
    let totalExtraItemPrice : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case afterDiscountAmount = "after_discount_amount"
        case beforeDiscountAmount = "before_discount_amount"
        case catId = "cat_id"
        case catName = "cat_name"
        case companyId = "company_id"
        case dateTime = "date_time"
        case discountAmount = "discount_amount"
        case extraItemId = "extra_item_id"
        case extraItemName = "extra_item_name"
        case extraItemPrice = "extra_item_price"
        case extraItemQty = "extra_item_qty"
        case id = "id"
        case offerApplyStatus = "offer_apply_status"
        case offerId = "offer_id"
        case productDetails = "product_details"
        case productId = "product_id"
        case productName = "product_name"
        case quantity = "quantity"
        case sizeId = "size_id"
        case sizeName = "size_name"
        case sizePrice = "size_price"
        case status = "status"
        case totalAmount = "total_amount"
        case totalExtraItemPrice = "total_extra_item_price"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        afterDiscountAmount = try values.decodeIfPresent(String.self, forKey: .afterDiscountAmount)
        beforeDiscountAmount = try values.decodeIfPresent(String.self, forKey: .beforeDiscountAmount)
        catId = try values.decodeIfPresent(String.self, forKey: .catId)
        catName = try values.decodeIfPresent(String.self, forKey: .catName)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        discountAmount = try values.decodeIfPresent(String.self, forKey: .discountAmount)
        extraItemId = try values.decodeIfPresent(String.self, forKey: .extraItemId)
        extraItemName = try values.decodeIfPresent(String.self, forKey: .extraItemName)
        extraItemPrice = try values.decodeIfPresent(String.self, forKey: .extraItemPrice)
        extraItemQty = try values.decodeIfPresent(String.self, forKey: .extraItemQty)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        offerApplyStatus = try values.decodeIfPresent(String.self, forKey: .offerApplyStatus)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        productDetails = try values.decodeIfPresent(RetProductDetail.self, forKey: .productDetails)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        sizeId = try values.decodeIfPresent(String.self, forKey: .sizeId)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        sizePrice = try values.decodeIfPresent(String.self, forKey: .sizePrice)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        totalExtraItemPrice = try values.decodeIfPresent(String.self, forKey: .totalExtraItemPrice)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}

struct RetProductDetail : Codable {
    
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
    let removeStatus : String?
    let restId : String?
    let salePrice : String?
    let stock : String?
    let type : String?
    let offer_available: String?
    
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
        case removeStatus = "remove_status"
        case restId = "rest_id"
        case salePrice = "sale_price"
        case stock = "stock"
        case type = "type"
        case offer_available = "offer_available"
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
        removeStatus = try values.decodeIfPresent(String.self, forKey: .removeStatus)
        restId = try values.decodeIfPresent(String.self, forKey: .restId)
        salePrice = try values.decodeIfPresent(String.self, forKey: .salePrice)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        offer_available = try values.decodeIfPresent(String.self, forKey: .offer_available)
    }
    
}


struct RetProductImage : Codable {
    
    let dateTime : String?
    let id : String?
    let image : String?
    let productId : String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "date_time"
        case id = "id"
        case image = "image"
        case productId = "product_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
    }    
}
