//
//  Api.swift
//  ServiceProvider
//
//  Created by mac on 25/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class Api: NSObject {
    
    static let shared = Api()
    
    func paramGetUserId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.string(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
    func paramGetDriverId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["driver_id"] = k.userDefault.string(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
    func paramGetRestId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["rest_id"] = k.userDefault.string(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
    func signup(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.signUp.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.stripeCustomerId)
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func sendOtpSignUp(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiOtpForSignUp) -> Void) {
        vc.blockUi()
        Service.post(url: Router.sendOtpSignUp.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiOtpForSignUp.self, from: response)
                if root.status == "1" {
                    if root.result != nil {
                        success(root)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProfile(_ vc: UIViewController, _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getProfile.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProfileTerms(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getProfile.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.updateProfile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func login(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.logIn.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.stripeCustomerId)
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    //    func forgotPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiForgotPassword) -> Void) {
    //        vc.blockUi()
    //        Service.post(url: Router.forgotPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
    //            do {
    //                let decoder = JSONDecoder()
    //                let root = try decoder.decode(ApiForgotPassword.self, from: response)
    //                if root.result != nil {
    //                    success(root)
    //                }
    //            } catch {
    //                print(error)
    //            }
    //            vc.unBlockUi()
    //        }) { (error: Error) in
    //            vc.alert(alertmessage: error.localizedDescription)
    //            vc.unBlockUi()
    //        }
    //    }
    //
    
    func setPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.changePassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getTopRestaurantList(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResRestaurant]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getTopRestaurant.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestaurant.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getCategoryList(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResCategory]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getCategory.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiCategory.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getBannerList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResBanner]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getBannerList.url(), params: [:], method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBanner.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getRestOfferList(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResRestOfferList]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getRestOfferList.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestOfferList.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    //    func verifyOtp(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiVerifyOtp) -> Void) {
    //        vc.blockUi()
    //        Service.post(url: Router.verifyOtp.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
    //            do {
    //                let decoder = JSONDecoder()
    //                let root = try decoder.decode(ApiVerifyOtp.self, from: response)
    //                if root.status == "1" {
    //                    success(root)
    //                } else {
    //                    vc.alert(alertmessage: R.string.localizable.somethingWentWrong())
    //                }
    //                vc.unBlockUi()
    //            } catch {
    //                print(error)
    //            }
    //        }) { (error: Error) in
    //            vc.alert(alertmessage: error.localizedDescription)
    //            vc.unBlockUi()
    //        }
    //    }
    //
    func getProductByCategory(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResProductsByCat]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getProductsByCategory.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProductsByCat.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProductDetail(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResUserProductDetail) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getProductDetail.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProductDetail.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getRestProductCustSide(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResProductsByCat]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getRestProductCustSide.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProductsByCat.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getPendingOrders(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResOrders]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getPendingOrders.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiOrders.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getCompletedOrders(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResOrders]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getCompletedOrders.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiOrders.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getFavouriteRest(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResFavourite]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getFavouriteProduct.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiFavourite.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    //
    //    func getOffers(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResProducts]) -> Void) {
    //        vc.blockUi()
    //        Service.post(url: Router.getOffers.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
    //            do {
    //                let decoder = JSONDecoder()
    //                let root = try decoder.decode(ApiProducts.self, from: response)
    //                if let result = root.result {
    //                    success(result)
    //                }
    //                vc.unBlockUi()
    //            } catch {
    //                print(error)
    //            }
    //            vc.unBlockUi()
    //        }) { (error: Error) in
    //            vc.alert(alertmessage: error.localizedDescription)
    //            vc.unBlockUi()
    //        }
    //    }
    
    func applyOffer(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiApplyOfferCode) -> Void) {
        Service.post(url: Router.applyOfferCode.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiApplyOfferCode.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }

    func getCart(_ vc: UIViewController, _ success: @escaping(_ responseData : ApiCart) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getCart.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiCart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addCart(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiAddToCart) -> Void) {
        vc.blockUi()
        Service.post(url: Router.addToCart.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddToCart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateCart(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiAddToCart) -> Void) {
        vc.blockUi()
        Service.post(url: Router.updateCart.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddToCart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteCart(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiAddToCart) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteCart.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddToCart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func placeOrder(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResPlaceOrder) -> Void) {
        Service.post(url: Router.placeOrder.url(), params: params, method: .post, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiPlaceOrder.self, from: response)
                if root.status == 1 {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
               
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }

    func estimateDeliveryFees(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiEstimateDeliveryFees) -> Void) {
        Service.post(url: Router.estimateDeliveryFees.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiEstimateDeliveryFees.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }

    func likeUnlike(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.likeUnlike.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getAddress(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResAddress]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getAddress.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddress.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addAddress(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAddress) -> Void) {
        Service.post(url: Router.addAddress.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddAddress.self, from: response)
                if let result = root.result {
                    if root.status == "1" {
                        success(result)
                    } else {
                        vc.alert(alertmessage: root.message ?? "")
                    }
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteAddress(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        Service.post(url: Router.deleteAddress.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    // MARK:-  Driver Side Api
    
    func drvGetNewRequest(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResDrvNewRequest]) -> Void) {
//        vc.blockUi()
        Service.post(url: Router.drvGetNewRequest.url(), params: self.paramGetDriverId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDrvNewRequest.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func drvGetOrder(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResDrvNewRequest]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.drvGetOrder.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDrvNewRequest.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func drvGetOrderDetail(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResDrvOrderDetail) -> Void) {
        vc.blockUi()
        Service.post(url: Router.drvGetOrderDetail.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDrvOrderDetail.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func drvGetRatingList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResDrvRatingList]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.drvRatingList.url(), params: self.paramGetDriverId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDrvRatingList.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getRatingList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResDrvRatingList]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getRatingList.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDrvRatingList.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func drvAccept(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
//        vc.blockUi()
        Service.post(url: Router.drvAcceptReject.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func drvDeliveryStatus(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.drvChangeDeliveryStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    // MARK:-  Restaurant Side Api
    
    func getRestOrders(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResRestOrder]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restGetOrder.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestOrder.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getRestReviewList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResDrvRatingList]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restRatingList.url(), params: self.paramGetRestId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDrvRatingList.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func restChangeStatus(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiRestChangeStatus) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restChangeStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestChangeStatus.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getRestEarnings(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiEarnings) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restGetEarnings.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiEarnings.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func restUpdate(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : RestUpdate) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.restUpdate.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestUpdate.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func restGetProfile(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResRestGetProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restGetProfile.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestGetProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func restAvailableDriver(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResRestAvailableDriver]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restAvailableDriver.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestAvailableDriver.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func restAssignDriver(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAssignDriver) -> Void) {
        vc.blockUi()
        Service.post(url: Router.restAssignDriver.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAssignDriver.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func withdrawalAmount(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResWithdrawAmount) -> Void) {
        vc.blockUi()
        Service.post(url: Router.withdrawalAmount.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiWithdrawAmount.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getDriverEarnings(_ vc: UIViewController, _ success: @escaping(_ responseData : ApiDriverEarning) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getMyEarnings.url(), params: self.paramGetDriverId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDriverEarning.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateOnlineStatus(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiUpdateOnlineStatus) -> Void) {
        vc.blockUi()
        Service.post(url: Router.updateOnlineStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiUpdateOnlineStatus.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func paymentGateway(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiPaymentGateway) -> Void) {
        vc.blockUi()
        Service.post(url: Router.paymentGateway.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiPaymentGateway.self, from: response)
                if root.hostedPaymentPageUrl != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func checkPaymentGateway(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiCheckPaymentStatus) -> Void) {
        vc.blockUi()
        Service.post(url: Router.checkPaymentGateway.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiCheckPaymentStatus.self, from: response)
                if root.status != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getNotificationList(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResNotification]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getNotificationList.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiNotification.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func reOrder(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.reOrder.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.status != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateDeliveryOption(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResRestGetProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.updateDeliveryOption.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiRestGetProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func tapToFavourite(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.tapToFavourite.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.status != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getGuestProfile(_ vc: UIViewController, _ success: @escaping(_ responseData : ResGuestProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getGuestProfile.url(), params: [:], method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiGuestProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteAccount(_ vc: UIViewController, _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteAccount.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.status != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func forgotPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.forgotPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.status != nil {
                    success(root)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
}
