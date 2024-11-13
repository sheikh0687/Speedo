//
//  CartsCell.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import UIKit

class CartsCell: UITableViewCell {
    
    @IBOutlet var img: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblQty: UILabel!
    
    var cloPlus:(()->Void)?
    var cloMinus:(()->Void)?
    var cloDelete:(()->Void)?
    var cloApplyCode:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data: ResCart) {
        print(data.productDetails)
        self.lblQty.text = data.quantity ?? ""
        self.lblCategoryName.text = data.catName ?? ""
        self.lblProductName.text = "\(data.productDetails?.itemName ?? "") (\(data.sizeName ?? ""))"
      
        self.lblDesc.text = data.extraItemName ?? ""
        Utility.setImageWithSDWebImage("\(Router.BASE_IMAGE_URL)\(data.productDetails?.image ?? "")", self.img)
        if let status = data.offerApplyStatus, status == "YES" {
            self.btnApply.setTitle("Applied", for: .normal)
            self.btnApply.isUserInteractionEnabled = false
            self.lblProductPrice.text = "\(data.totalAmount ?? "") \(k.currency) (\(data.discountAmount ?? "") \(k.currency) off)"
        } else {
            self.btnApply.setTitle("Apply Offer", for: .normal)
            self.btnApply.isUserInteractionEnabled = true
            self.lblProductPrice.text = "\(data.totalAmount ?? "") \(k.currency) "
        }
        if let offer_available = data.productDetails?.offer_available, offer_available == "Yes" {
            self.btnApply.isHidden = false
        } else {
            self.btnApply.isHidden = true
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        self.cloPlus?()
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        self.cloMinus?()
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloDelete?()
    }
    
    @IBAction func btnApplyCode(_ sender: UIButton) {
        self.cloApplyCode?()
    }
}
