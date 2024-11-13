//
//  ResPrintVC.swift
//  Speedo
//
//  Created by mac on 28/07/21.
//

import UIKit

class ResPrintVC: UIViewController {
    
    @IBOutlet weak var imgPrint: UIImageView!
    @IBOutlet weak var vwPrint: UIView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblCVR: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPinCode: UILabel!
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblOrderDateTime: UILabel!
    @IBOutlet weak var lblDeliveryTime: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDeliveryFees: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblPaid: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddressUser: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var constraintTableViewOt: NSLayoutConstraint!
    
    var orderId = ""
    var identifier = "ProductPrintCell"
    var arr:[ResCartDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: "Print", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
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
        Swift.print(self.paramRequest())
        Api.shared.drvGetOrderDetail(self, self.paramRequest()) { (response) in
            self.lblRestaurantName.text = response.restDetails?.restName ?? ""
            self.lblCVR.text = "\(R.string.localizable.vegaInvestApsCVR()) \(response.restDetails?.taxNumber ?? "")"
            self.lblAddress.text = response.restDetails?.address ?? ""
            self.lblPinCode.text = "\(R.string.localizable.tlF()) \(response.restDetails?.mobile ?? "")"
            
            self.lblOrderId.text = "\(R.string.localizable.orderId()) \(response.id ?? "")"
            self.lblOrderDateTime.text = response.dateTime ?? ""
            
            if response.date != "" && response.time != "" {
                self.lblDeliveryTime.text = "\(response.time ?? "") \(response.date ?? "")"
            } else {
                self.lblDeliveryTime.text = response.dateTime ?? ""
            }
            
            self.arr = response.cartDetails ?? []
            self.constraintTableViewOt.constant = CGFloat(((response.cartDetails?.count ?? 0) * 25))
            self.tableViewOt.reloadData()
            
            self.lblSubTotal.text = "\(response.subTotal ?? "")\(k.currency)"
            self.lblDiscount.text = "\(response.discountAmt ?? "")\(k.currency)"
            self.lblDeliveryFees.text = "\(response.deliveryFee ?? "")\(k.currency)"
            
            self.lblTotalAmount.text = "\(response.totalAmount ?? "")\(k.currency)"
            if let payment = response.paymentMethod, payment == "Cash" || payment == "cash" {
                self.lblPaid.text = R.string.localizable.notPaid()
            } else {
                self.lblPaid.text = response.paymentMethod ?? ""
            }
            
            self.lblName.text = "\(R.string.localizable.name()) \(response.userDetails?.firstName ?? "") \(response.userDetails?.lastName ?? "")"
            self.lblAddressUser.text = "\(R.string.localizable.address()) \(response.addressDetails?.address ?? "")"
            self.lblPhone.text = "\(R.string.localizable.mobile())\(response.userDetails?.mobile ?? "")"
        }
    }
    
    @IBAction func btnPrint(_ sender: UIButton) {
        self.print()
    }
    
    func print() {
        let info = UIPrintInfo(dictionary:nil)
        info.outputType = UIPrintInfo.OutputType.general
        info.jobName = "Printing"
        
        let vc = UIPrintInteractionController.shared
        vc.printInfo = info
        
        vc.printingItem = UIImage.image(fromView: self.vwPrint) // your view here
        
        vc.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
    }
    
    func createPDFDataFromImage(image: UIImage) -> NSMutableData {
        let pdfData = NSMutableData()
        let imgView = UIImageView.init(image: image)
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        imgView.layer.render(in: context!)
        UIGraphicsEndPDFContext()
        
        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let path = dir?.appendingPathComponent("file.pdf")
        
        do {
            try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
        } catch {
            Swift.print("error catched")
        }
        
        return pdfData
    }
}

extension ResPrintVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.productPrintCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblItemName.text = "\(obj.quantity ?? "") X \(obj.productName ?? "") (\(obj.sizeName ?? ""))"
        cell.lblPrice.text = "\(obj.totalAmount ?? "")\(k.currency)"
        return cell
    }
}

extension ResPrintVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}

extension UIImage {

    /// Get image from given view
    ///
    /// - Parameter view: the view
    /// - Returns: UIImage
    public class func image(fromView view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIView {
    
    func viewCapture() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        guard let cgContext = UIGraphicsGetCurrentContext() else {
            print("Fail to get CGContext")
            return nil
        }
        self.layer.render(in: cgContext)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            print("Fail to get Image from current image context")
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIApplication {
    
    func getScreenshot() -> UIImage? {
        guard let window = keyWindow else { return nil }
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        window.drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
//        let snap = UIScreen.main.snapshotView(afterScreenUpdates: false)
//let image = UIApplication.shared.getScreenshot()
//        let image = self.vwPrint.viewCapture()
//        self.imgPrint.image = image
//        self.view.bringSubviewToFront(imgPrint)
//        self.createPDFDataFromImage(image: <#T##UIImage#>)
