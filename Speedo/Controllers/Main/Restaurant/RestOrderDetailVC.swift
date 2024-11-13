//
//  RestOrderDetailVC.swift
//  Speedo
//
//  Created by mac on 08/09/21.
//

import UIKit
import MapKit

class RestOrderDetailVC: UIViewController {
   
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblPayBy: UILabel!
    @IBOutlet weak var vwDriverDetail: UIView!
    @IBOutlet weak var vwDriverHeading: UIView!
    
    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var lblRest: UILabel!
    @IBOutlet weak var lblRestTotalAmount: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblOrderIdd: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGrandTotalAmount: UILabel!
    @IBOutlet weak var lblCustomerLabel: UILabel!
    
    var orderId = ""
    var comingFrom = ""
    var mobileNo = ""
    var objAnnotation: MapAnnotation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.comingFrom == "USER" {
            self.lblCustomerLabel.text = R.string.localizable.assignedDriver()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.orderDetails(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getOrderDetail()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func paramRequest() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["order_id"] = self.orderId as AnyObject
        return dict
    }
    
    func getOrderDetail() {
        Api.shared.drvGetOrderDetail(self, self.paramRequest()) { (response) in
            let obj = response
            let objRest = obj.restDetails
            
            self.lblTotalAmount.text = "\(k.currency) \(obj.totalAmount ?? "")"
            self.lblOrderId.text = "\(R.string.localizable.orderId()) \(obj.id ?? "")"
            self.lblOrderDate.text = obj.dateTime ?? ""
            self.lblPayBy.text = obj.paymentMethod ?? ""
            
            self.lblRest.text = "\(obj.userDetails?.firstName ?? "") \(obj.userDetails?.lastName ?? "")"
            Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", self.imgRest)
            self.lblAddress.text = obj.addressDetails?.address ?? ""
            
            self.lblOrderIdd.text = "Order ID : \(obj.id ?? "")"
            let status = obj.status ?? ""
            switch status {
            case "Pending":
                self.lblStatus.text = R.string.localizable.pending()
            case "Accept":
                self.lblStatus.text = R.string.localizable.preparing()
            case "Preparing":
                self.lblStatus.text = R.string.localizable.preparing()
            case "Ready":
                if let deliveryType = obj.acceptDriverId, deliveryType != "" {
                    self.lblStatus.text = R.string.localizable.onTheWayToPickup()
                } else {
                    self.lblStatus.text = R.string.localizable.notifyDriverAgain()
                }
            case "Reject":
                self.lblStatus.text = "Rejected"
            default:
                self.lblStatus.text = "Pending"
            }
            
            let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
            self.lblItems.text = arrItems
            
            if let acceptDriverId = obj.acceptDriverId, acceptDriverId != "" {
                self.vwDriverDetail.isHidden = false
                self.vwDriverHeading.isHidden = false
                
                self.lblUserName.text = "\(obj.driverDetails?.firstName ?? "") \(obj.driverDetails?.lastName ?? "")"
                self.lblUserAddress.text = obj.driverDetails?.address ?? ""
                Utility.setImageWithSDWebImage(obj.driverDetails?.image ?? "", self.imgUser)
                self.mobileNo = obj.driverDetails?.mobile ?? ""
            } else {
                self.vwDriverDetail.isHidden = true
                self.vwDriverHeading.isHidden = true
            }
            
            self.lblSubTotal.text = "\(k.currency) \(obj.totalAmount ?? "")"
            self.lblDiscount.text = "\(k.currency) \(obj.deliveryFee ?? "")"
            self.lblGrandTotalAmount.text = "\(k.currency) \(obj.totalAmount ?? "")"
            
            let latDropOff = Double(obj.driverDetails?.lat ?? "") ?? 0.0
            let lonDropOff = Double(obj.driverDetails?.lon ?? "") ?? 0.0
            
            let coordinates1 = CLLocationCoordinate2D(latitude: latDropOff, longitude: lonDropOff)
            let objAnnotation = CustomPointAnnotation()
            objAnnotation.coordinate = coordinates1
            objAnnotation.title = ""
            objAnnotation.imageName = "delivery_marker"
            objAnnotation.isDriver = false
            self.mapView.addAnnotation(objAnnotation)
            
//            let coordinates2 = CLLocationCoordinate2D(latitude: kAppDelegate.coordinate2.coordinate.latitude, longitude: kAppDelegate.coordinate2.coordinate.longitude)
//            let objAnnotation2 = CustomPointAnnotation()
//            objAnnotation2.coordinate = coordinates2
//            objAnnotation2.title = ""
//            objAnnotation2.imageName = "delivery_marker"
//            objAnnotation.isDriver = true
//            self.mapView.addAnnotation(objAnnotation2)
            
            let region = MKCoordinateRegion(center: coordinates1, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
        Utility.callNumber(phoneNumber: self.mobileNo)
    }
}


extension RestOrderDetailVC: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        guard !(annotation is MKUserLocation) else {
//            return nil
//        }
//        let reuseId = "test"
//        var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? AnnotationViewNew
//        if let annotationView = annotView {
//            return annotationView
//        } else {
//            annotView = AnnotationViewNew(annotation: annotation, reuseIdentifier: reuseId)
//            let pinIcon = UIImage(named: "delivery_marker")
//            annotView?.btnInfo = UIButton()
//            annotView?.frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width, height: pinIcon!.size.height)
//            annotView?.btnInfo?.frame = annotView?.frame ?? CGRect.zero
//            annotView?.btnInfo?.setBackgroundImage(pinIcon, for: .normal)
//            annotView?.addSubview(annotView?.btnInfo ?? UIButton())
//            return annotView
//        }
//        return annotView
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        let identifier = "CustomViewAnnotation"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            anView!.canShowCallout = true
        } else {
            anView!.annotation = annotation
        }
        let cc = annotation as! CustomPointAnnotation
        anView?.image = UIImage.init(named: "delivery_marker")
        return anView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //        if let overlay = overlay as? MKPolyline {
        /// define a list of colors you want in your gradient
        let gradientColors = [ hexStringToUIColor(hex: "#8728E2"), hexStringToUIColor(hex: "#3B67F7")]
        
        /// Initialise a GradientPathRenderer with the colors
        let polylineRenderer = GradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
        
        /// set a linewidth
        polylineRenderer.lineWidth = 7
        return polylineRenderer
        //        }
    }
}

class AnnotationViewNew: MKAnnotationView {
    var btnInfo: UIButton?
}
