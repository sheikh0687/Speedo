//
//  RestaurantMenuVC.swift
//  Speedo
//
//  Created by mac on 19/04/21.
//

import UIKit
import Cosmos

class RestaurantMenuVC: UIViewController {

    @IBOutlet var vwMenu: UIView!
    @IBOutlet var vwReview: UIView!
    @IBOutlet var lblMenu: UILabel!
    @IBOutlet var lblReview: UILabel!
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnReview: UIButton!
    
    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblRestName: UILabel!
    @IBOutlet weak var lblSpeciality: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var vwRatingInMenu: CosmosView!
    
    @IBOutlet weak var lblTotalCart: UILabel!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var vwCart: UIView!
    
    var objRest:ResRestaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblMenu.isHidden = false
        self.lblReview.isHidden = true
        self.vwMenu.isHidden = false
        self.vwReview.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.menu(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        if let obj = objRest {
            print(obj)
            self.lblRestName.text = obj.restName ?? ""
            Utility.setImageWithSDWebImage(obj.restCoverImage ?? "", self.imgRest)
            Utility.setImageWithSDWebImage(obj.restImage ?? "", self.imgDish)
            
            self.lblStatus.text = obj.restOpenStatus ?? ""
            if let status = obj.restOpenStatus, status == "CLOSE" {
                self.lblStatus.backgroundColor = .red
            }
            self.lblSpeciality.text = obj.aboutMe ?? ""
            print(obj.avgRating ?? "")
            print(Double(obj.avgRating ?? "") ?? 0.0)
            self.vwRatingInMenu.rating = Double(obj.avgRating ?? "") ?? 0.0
            self.vwRatingInMenu.text = "(\(obj.totalRatingCount ?? ""))"
        }
        self.getCart() 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getCart() {
        Api.shared.getCart(self) { (response) in
            if let cartCount = response.totalCart, cartCount != "" {
                self.vwCart.isHidden = false
                self.lblTotalCart.text = "\(R.string.localizable.totalCart()) (\(k.currency) \(response.totalAmount ?? ""))"
                self.lblTotalCount.text = response.totalCart ?? ""
            } else {
                self.vwCart.isHidden = true
            }
        }
    }
    
    @IBAction func btnReview(_ sender: UIButton) {
        self.lblMenu.isHidden = true
        self.lblReview.isHidden = false
        self.vwMenu.isHidden = true
        self.vwReview.isHidden = false
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        self.lblMenu.isHidden = false
        self.lblReview.isHidden = true
        self.vwMenu.isHidden = false
        self.vwReview.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResMenuVC {
            vc.restId = self.objRest?.id ?? ""
        }
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
