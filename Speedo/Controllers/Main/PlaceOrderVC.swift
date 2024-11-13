//
//  PlaceOrderVC.swift
//  Speedo
//
//  Created by mac on 20/04/21.
//

import UIKit

class PlaceOrderVC: UIViewController {

    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var btnPickYourSelf: UIButton!
    @IBOutlet weak var btnDelivery: UIButton!
    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var btnCash: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var vwLocation: UIView!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var lblDelivery: UILabel!
    
    var selectedDate = ""
    var selectedTime = ""
    var selectedDelivery = "Pickup"
    var selectedPayment = ""
    var selectedPayType = "cash"
    
    var totalAmount = ""
    var discountAmount = ""
    var subtotal = ""
    
    var address = ""
    var addressTitle = ""
    var lat = "0.0"
    var lon = "0.0"
    
    var deliveryAmount = ""
    var deliveryFareByAdmin = ""
    var offerId = ""
    
    var delKm = "0.0"
    var orderType = "Current"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.orderDetails(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        if globalDeliveryOption == "No" {
            self.btnDelivery.isHidden = true
            self.lblDelivery.isHidden = false
        } else {
            self.btnDelivery.isHidden = false
            self.lblDelivery.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCart() {
        Api.shared.getCart(self) { (response) in
            self.subtotal = response.beforeDiscountAmount ?? ""
            self.discountAmount = response.totalDiscountAmount ?? ""
            self.totalAmount = response.totalAmount ?? ""
            
            if let beforeAmount = response.beforeDiscountAmount, beforeAmount != "" {
                self.lblSubtotal.text = "\(beforeAmount) \(k.currency)"
            } else {
                self.lblSubtotal.text = "0.00 \(k.currency)"
            }
            
            if let deliveryFee = response.deliveryFee, deliveryFee != "" {
                self.lblDeliveryFee.text = "\(deliveryFee) \(k.currency)"
            } else {
                self.lblDeliveryFee.text = "0.00 \(k.currency)"
            }
            
            if let totalDiscountAmount = response.totalDiscountAmount, totalDiscountAmount != "" {
                self.lblDiscount.text = "\(totalDiscountAmount) \(k.currency)"
            } else {
                self.lblDiscount.text = "0.00 \(k.currency)"
            }
            
            if let totalAmount = response.totalAmount, totalAmount != "" {
                self.lblGrandTotal.text = "\(totalAmount) \(k.currency)"
            } else {
                self.lblGrandTotal.text = "0.00 \(k.currency)"
            }

            let arrOfferId = response.result?.filter({ $0.offerId != "" }).map({ $0.offerId ?? "" })
            self.offerId = arrOfferId?.joined(separator: ",") ?? ""
        }
    }
    
    @IBAction func btnDate(_ sender: UIButton) {
        self.orderType = "Later"
        self.datePickerTapped(strFormat: "yyyy-MM-dd", mode: .date, completionBlock: { (datestring) in
            sender.setTitleColor(.black, for: .normal)
            sender.setTitle(datestring, for: .normal)
            self.selectedDate = datestring
        })
    }
    
    @IBAction func btnTime(_ sender: UIButton) {
        self.orderType = "Later"
        self.datePickerTapped(strFormat: "HH:mm:ss", mode: .time, completionBlock: { (datestring) in
            sender.setTitleColor(.black, for: .normal)
            sender.setTitle(datestring, for: .normal)
            self.selectedTime = datestring
        })
    }
    
    @IBAction func btnPickYourSelf(_ sender: UIButton) {
        self.btnPickYourSelf.setImage(R.image.radio_check(), for: .normal)
        self.btnDelivery.setImage(R.image.radio_uncheck(), for: .normal)
        self.selectedDelivery = "Pickup"
        self.btnCash.isHidden = false
        self.vwLocation.isHidden = true
        self.getCart()
    }
    
    @IBAction func btnDelivery(_ sender: UIButton) {
        self.address = ""
        self.lat = "0.0"
        self.lon = "0.0"
        self.addressTitle = ""
        self.btnAddress.setTitle("", for: .normal)
        
        self.btnPickYourSelf.setImage(R.image.radio_uncheck(), for: .normal)
        self.btnDelivery.setImage(R.image.radio_check(), for: .normal)
        self.selectedDelivery = "Delivery"
        self.btnCash.isHidden = true
        self.vwLocation.isHidden = false
        self.btnCash.setImage(R.image.radio_uncheck(), for: .normal)
        self.btnCard.setImage(R.image.radio_check(), for: .normal)
        self.selectedPayment = "Online"
        self.selectedPayType = "Online"
    }
    
    @IBAction func btnCard(_ sender: UIButton) {
        self.btnCard.setImage(R.image.radio_check(), for: .normal)
        self.btnCash.setImage(R.image.radio_uncheck(), for: .normal)
        self.selectedPayType = "Online"
    }
    
    @IBAction func btnCash(_ sender: UIButton) {
        self.btnCard.setImage(R.image.radio_uncheck(), for: .normal)
        self.btnCash.setImage(R.image.radio_check(), for: .normal)
        self.selectedPayType = "cash"
    }
    
    @IBAction func btnAddress(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MyAddressVC") as! MyAddressVC
        vc.comingFrom = "placeorder"
        vc.cloSelect = { (addressId, address, lat, lon, title) in
            self.address = address
            self.lat = lat
            self.lon = lon
            self.addressTitle = title
            self.btnAddress.setTitle(address, for: .normal)
            self.getEstimateDeliveryFees(lat, lon)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getEstimateDeliveryFees(_ lat: String, _ lon: String) {
        Api.shared.estimateDeliveryFees(self, self.paramEstimateDeliveryFees(lat, lon)) { (response) in
            self.deliveryAmount = response.fare ?? ""
            self.deliveryFareByAdmin = response.driverFareByAdmin ?? ""
            var deliveryFee = 0.0
            if let deliveryAmt = response.fare, deliveryAmt != "" {
                deliveryFee = Double(deliveryAmt) ?? 0.0
            }
            let beforeDiscount = Double(self.subtotal) ?? 0.0
            var disAmount = 0.0
            if self.discountAmount != "" {
                disAmount = Double(self.discountAmount) ?? 0.0
            }
            let tot = beforeDiscount + deliveryFee - disAmount
            self.totalAmount = String(tot)
            let y = Double(round(100*deliveryFee)/100)
            let yr = Double(round(100*tot)/100)
            self.lblDeliveryFee.text = "\(y) \(k.currency)"
            self.lblGrandTotal.text = "\(yr) \(k.currency)"
            self.delKm = response.distance ?? ""
        }
    }
    
    func paramEstimateDeliveryFees(_ lat: String, _ lon: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId)! as AnyObject
        dict["dropoff_lat"] = lat as AnyObject
        dict["dropoff_lon"] = lon as AnyObject
        return dict
    }
    
    @IBAction func btnOrderNow(_ sender: UIButton) {
        print(self.paramOrderNow())
        if self.selectedDelivery == "Delivery" {
            if self.lat == "0.0" {
                Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.pleaseSelectAddress(), delegate: nil, parentViewController: self)
            } else {
                self.placeOrder()
            }
        } else {
            self.placeOrder()
        }
    }
    
    func placeOrder() {
        Api.shared.placeOrder(self, self.paramOrderNow()) { (response) in
            if self.selectedPayType == "Online" {
                self.paymentGateway(response.id ?? "")
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.orderPlacedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                    Switcher.updateRootVC()
                }
            }
        }
    }
    
    func paramOrderNow() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["total_amount"] = self.totalAmount as AnyObject
        dict["payment_method"] = self.selectedPayType as AnyObject
        dict["pay_type"] = self.selectedPayType as AnyObject
        dict["first_order_status"] = k.emptyString as AnyObject
        dict["company_id"] = k.userDefault.value(forKey: k.session.interestedRestId)! as AnyObject
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId)! as AnyObject
        dict["discount_amt"] = self.discountAmount as AnyObject
        
        dict["delivery_fee_by_admin"] = self.deliveryFareByAdmin as AnyObject
        dict["delivery_fee"] = self.deliveryAmount as AnyObject
        dict["sub_total"] = self.subtotal as AnyObject
        
        dict["address"] = self.address as AnyObject
        dict["lat"] = self.lat as AnyObject
        dict["lon"] = self.lon as AnyObject
        dict["title"] = self.addressTitle as AnyObject
        
        dict["delivery_type"] = self.selectedDelivery as AnyObject
        if self.selectedDate != "" {
            dict["date"] = self.selectedDate as AnyObject
            dict["offer_check_date"] = self.selectedDate as AnyObject
        } else {
            dict["date"] = Utility.getCurrentDate() as AnyObject
            dict["offer_check_date"] = Utility.getCurrentDate() as AnyObject
        }
        if self.selectedTime != "" {
            dict["time"] = self.selectedTime as AnyObject
        } else {
            dict["time"] = Utility.getCurrentTime() as AnyObject
        }
        
        dict["offer_id"] = self.offerId as AnyObject
        
        dict["gift_id"] = k.emptyString as AnyObject
        dict["cutlery"] = k.emptyString as AnyObject
        dict["del_km"] = self.delKm as AnyObject
        dict["order_type"] = self.orderType as AnyObject
        return dict
    }
    
    func paramPaymentGateway(_ orderId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["order_id"] = orderId as AnyObject
        dict["payment_method"] = self.selectedPayType as AnyObject
        dict["total_amount"] = self.totalAmount as AnyObject
        dict["m_key"] = k.emptyString as AnyObject
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId)! as AnyObject
        return dict
    }
    
    func paymentGateway(_ orderId: String) {
        Api.shared.paymentGateway(self, self.paramPaymentGateway(orderId)) { (response) in
            let webviewUrl = response.hostedPaymentPageUrl ?? ""
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentGatewayVC") as! PaymentGatewayVC
            vc.paymentGatewayUrl = webviewUrl
            vc.orderId = orderId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
