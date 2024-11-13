//
//  CartCell.swift
//  Cobee
//
//  Created by Shoaib on 20/12/20.
//

import UIKit

class CartCell: UICollectionViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    
    var cloPlus:(()->Void)?
    var cloMinus:(()->Void)?
    var cloDelete:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: ResCart) {
        self.lblCategoryName.text = data.productDetails?.catName ?? ""
        self.lblProductName.text = data.productDetails?.itemName ?? ""
        self.lblProductPrice.text = "\(k.currency) \(data.totalAmount ?? "")"
        self.lblDesc.text = data.extraItemName ?? ""
        Utility.setImageWithSDWebImage(data.productDetails?.image ?? "", self.img)
        self.lblSize.text = "(\(data.sizeName ?? ""))"
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
}
