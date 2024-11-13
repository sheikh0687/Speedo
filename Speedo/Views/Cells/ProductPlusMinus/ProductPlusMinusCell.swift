//
//  ProductPlusMinusCell.swift
//  Speedo
//
//  Created by mac on 18/06/21.
//

import UIKit

class ProductPlusMinusCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    
    var cloCheck:((_ isCheck: Bool)->Void)?
    var cloUpdate:((_ isCheck: Bool,_ isPlus: Bool, _ qty: Int)-> Void)?
    @IBOutlet weak var lblQty: UILabel!
    var qty = 1
    var cloQty:((_ isCheck: Bool)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnCheck.setImage(R.image.check_box_nill_18pt(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if btnCheck.image(for: .normal) == R.image.check_box_nill_18pt() {
            self.btnCheck.setImage(R.image.check_box_fill_18pt(), for: .normal)
            self.cloCheck?(true)
        } else {
            self.btnCheck.setImage(R.image.check_box_nill_18pt(), for: .normal)
            self.cloCheck?(false)
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        self.qty = self.qty + 1
        self.lblQty.text = "\(self.qty)"
        if btnCheck.image(for: .normal) == R.image.check_box_nill_18pt() {
            self.cloUpdate?(false, true, self.qty)
        } else {
            self.cloUpdate?(true, true, self.qty)
        }
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        if self.qty > 1 {
            self.qty = self.qty - 1
            self.lblQty.text = "\(self.qty)"
            if btnCheck.image(for: .normal) == R.image.check_box_nill_18pt() {
                self.cloUpdate?(false, false, self.qty)
            } else {
                self.cloUpdate?(true, false, self.qty)
            }
        }
    }
    
}
