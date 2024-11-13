//
//  Router.swift
//  ServiceProvider
//
//  Created by mac on 12/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation


enum Router: String {
    
    static let BASE_SERVICE_URL = "http://speedybondos.dk/Speedybondos/webservice/"
    static let BASE_IMAGE_URL = "http://speedybondos.dk/Speedybondos/uploads/images/"
    static let BASE_URL_POSTCODE = ""
    
    case logIn
    case signUp
    case getProfile
    case forgotPassword
    case updateProfile
    case changePassword
    case verifyOtp
    case sendOtpSignUp
    
    case getCategory
    case getTopRestaurant
    case getRestOfferList
    case getBannerList
    
    case getProductsByCategory
    case getRestProductCustSide
    case getProductDetail
    
    case getPendingOrders
    case getCompletedOrders
    
    case getFavouriteProduct
    case getOffers
    
    case addGift
    
    case addToCart
    case getCart
    case updateCart
    case deleteCart
    case placeOrder
    
    case addPayment
    case likeUnlike
    case cancelOrder
    
    case applyOfferCode
    case estimateDeliveryFees
    
    case getAddress
    case addAddress
    case deleteAddress
    
    case getRatingList
    
    // MARK:-  Driver Side Api
    case drvGetNewRequest
    case drvGetOrder
    case drvGetOrderDetail
    case drvRatingList
    case drvAcceptReject
    case drvChangeDeliveryStatus
    
    case addRating
    case withdrawalAmount
    case getMyEarnings
    case updateOnlineStatus
    
    // MARK:-  Restaurant Side Api
    case restGetOrder
    case restRatingList
    case restChangeStatus
    case restGetEarnings
    case restUpdate
    case restGetProfile
    case restAvailableDriver
    case restAssignDriver
    
    case paymentGateway
    case checkPaymentGateway
    case getNotificationList
    
    case reOrder
    case updateDeliveryOption
    case tapToFavourite
    
    case getGuestProfile
    case deleteAccount
    
    public func url() -> String {
        switch self {
        case .logIn:
            return Router.oAuthRoute(path: "login")
        case .forgotPassword:
            return Router.oAuthRoute(path: "forgot_password")
        case .signUp:
            return Router.oAuthRoute(path: "signup")
        case .getProfile:
            return Router.oAuthRoute(path: "get_profile")
        case .updateProfile:
            return Router.oAuthRoute(path: "update_profile")
        case .changePassword:
            return Router.oAuthRoute(path: "change_password")
        case .verifyOtp:
            return Router.oAuthRoute(path: "verify_number")
        case .sendOtpSignUp:
            return Router.oAuthRoute(path: "mobile_verify")
            
        case .getTopRestaurant:
            return Router.oAuthRoute(path: "get_interested_rest_details")
        case .getCategory:
            return Router.oAuthRoute(path: "category_list")
        case .getBannerList:
            return Router.oAuthRoute(path: "banner_list")
        case .getRestOfferList:
            return Router.oAuthRoute(path: "get_rest_offers_list")
            
        case .getProductsByCategory:
            return Router.oAuthRoute(path: "get_product_list_by_category")
        case .getRestProductCustSide:
            return Router.oAuthRoute(path: "get_rest_product_customer_side")
        case .getProductDetail:
            return Router.oAuthRoute(path: "get_product_details")
            
        case .getPendingOrders:
            return Router.oAuthRoute(path: "get_user_order_by_status")
        case .getCompletedOrders:
            return Router.oAuthRoute(path: "get_user_order_by_status")
            
        case .getFavouriteProduct:
            return Router.oAuthRoute(path: "get_my_fav_product")
        case .getOffers:
            return Router.oAuthRoute(path: "get_offers_product_list")
        case .addGift:
            return Router.oAuthRoute(path: "apply_gift_offer")
            
        case .addToCart:
            return Router.oAuthRoute(path: "add_to_cart_product")
        case .getCart:
            return Router.oAuthRoute(path: "get_cart")
        case .updateCart:
            return Router.oAuthRoute(path: "update_cart")
        case .deleteCart:
            return Router.oAuthRoute(path: "delete_cart_item")
        case .placeOrder:
            return Router.oAuthRoute(path: "place_order")
            
        case .addPayment:
            return Router.oAuthRoute(path: "addPayment")
        case .likeUnlike:
            return Router.oAuthRoute(path: "like_unlike_product")
        case .cancelOrder:
            return Router.oAuthRoute(path: "order_cancel_by_user")
        case .getRatingList:
            return Router.oAuthRoute(path: "get_user_review_rating")
            
        case .drvGetNewRequest:
            return Router.oAuthRoute(path: "get_driver_pending_request")
        case .drvGetOrder:
            return Router.oAuthRoute(path: "get_driver_current_request")
        case .drvGetOrderDetail:
            return Router.oAuthRoute(path: "get_order_details")
        case .drvRatingList:
            return Router.oAuthRoute(path: "get_driver_review_rating")
        case .drvAcceptReject:
            return Router.oAuthRoute(path: "accept_reject_request_by_driver")
        case .drvChangeDeliveryStatus:
            return Router.oAuthRoute(path: "driver_change_delivery_status")
        case .addRating:
            return Router.oAuthRoute(path: "add_rating_review")
            
        case .restGetOrder:
            return Router.oAuthRoute(path: "get_rest_order_by_status")
        case .restRatingList:
            return Router.oAuthRoute(path: "get_rest_review_rating")
        case .restChangeStatus:
            return Router.oAuthRoute(path: "change_order_status")
        case .restGetEarnings:
            return Router.oAuthRoute(path: "get_rest_total_earning")
            
        case .applyOfferCode:
            return Router.oAuthRoute(path: "apply_offer")
        case .estimateDeliveryFees:
            return Router.oAuthRoute(path: "estimate_delivery_fare_calculation")
            
        case .getAddress:
            return Router.oAuthRoute(path: "get_user_address")
        case .addAddress:
            return Router.oAuthRoute(path: "add_user_address")
        case .deleteAddress:
            return Router.oAuthRoute(path: "delete_user_address")
            
        case .restUpdate:
            return Router.oAuthRoute(path: "update_rest_profile")
        case .restGetProfile:
            return Router.oAuthRoute(path: "get_rest_profile")
        case .restAvailableDriver:
            return Router.oAuthRoute(path: "get_nearbuy_driver")
        case .restAssignDriver:
            return Router.oAuthRoute(path: "order_assign_by_rest")
            
        case .withdrawalAmount:
            return Router.oAuthRoute(path: "add_withdraw_request")
        case .updateOnlineStatus:
            return Router.oAuthRoute(path: "update_driver_available_status")
        case .getMyEarnings:
            return Router.oAuthRoute(path: "get_driver_total_earning")
            
        case .paymentGateway:
            return Router.oAuthRoute(path: "nets_online_payment")
        case .checkPaymentGateway:
            return Router.oAuthRoute(path: "check_order")
        case .getNotificationList:
            return Router.oAuthRoute(path: "get_user_notification_list")
            
        case .reOrder:
            return Router.oAuthRoute(path: "reorder")
        case .updateDeliveryOption:
            return Router.oAuthRoute(path: "update_delivery_option")
            
        case .tapToFavourite:
            return Router.oAuthRoute(path: "like_unlike_product")
        case .getGuestProfile:
            return Router.oAuthRoute(path: "get_guest_user_profile")
        case .deleteAccount:
            return Router.oAuthRoute(path: "delete_account")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
    
}
