//
//  DrvOrderDetailVC.swift
//  Speedo
//
//  Created by mac on 24/05/21.
//

import UIKit
import MapKit

class DrvOrderDetailVC: UIViewController {
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblPayBy: UILabel!
    
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
            
            self.lblRest.text = objRest?.restName ?? ""
            Utility.setImageWithSDWebImage(objRest?.restImage ?? "", self.imgRest)
            self.lblAddress.text = objRest?.address ?? ""
            
            self.lblOrderIdd.text = "\(R.string.localizable.orderId()) \(obj.id ?? "")"
            
            
            let arrItems = obj.productDetails?.map({ "\($0.quantity ?? "") x \($0.itemName ?? "")" }).joined(separator: ",")
            self.lblItems.text = arrItems
            
            if self.comingFrom == "USER" {
                self.lblUserName.text = ""
            } else {
                self.lblUserName.text = obj.userDetails?.firstName ?? ""
                self.lblUserAddress.text = obj.addressDetails?.address ?? ""
                Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", self.imgUser)
            }
            
            self.lblSubTotal.text = "\(obj.subTotal ?? "") \(k.currency)"
            self.lblDiscount.text = "\(obj.deliveryFee ?? "") \(k.currency)"
            self.lblGrandTotalAmount.text = "\(obj.totalAmount ?? "") \(k.currency)"
            
            let latDropOff = Double(obj.restDetails?.lat ?? "") ?? 0.0
            let lonDropOff = Double(obj.restDetails?.lon ?? "") ?? 0.0
            
            let coordinates1 = CLLocationCoordinate2D(latitude: latDropOff, longitude: lonDropOff)
            let objAnnotation = CustomPointAnnotation()
            objAnnotation.coordinate = coordinates1
            objAnnotation.title = ""
            objAnnotation.imageName = "restaurant_marker"
            objAnnotation.isDriver = false
            objAnnotation.isUser = false
            self.mapView.addAnnotation(objAnnotation)
            
            let latDropOff1 = Double(obj.addressDetails?.lat ?? "") ?? 0.0
            let lonDropOff1 = Double(obj.addressDetails?.lon ?? "") ?? 0.0
            
            let coordinates2 = CLLocationCoordinate2D(latitude: latDropOff1, longitude: lonDropOff1)
            let objAnnotation1 = CustomPointAnnotation()
            objAnnotation1.coordinate = coordinates2
            objAnnotation1.title = ""
            objAnnotation1.imageName = "user_marker"
            objAnnotation1.isDriver = false
            objAnnotation.isUser = true
            self.mapView.addAnnotation(objAnnotation1)
                    
            if let status = obj.status, status != "Accept" {
                let region = MKCoordinateRegion(center: coordinates2, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
                self.mapView.setRegion(region, animated: true)
            } else {
                let region = MKCoordinateRegion(center: coordinates1, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}

extension DrvOrderDetailVC: MKMapViewDelegate {
    
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
        anView?.image = UIImage.init(named: cc.imageName ?? "")
        
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
