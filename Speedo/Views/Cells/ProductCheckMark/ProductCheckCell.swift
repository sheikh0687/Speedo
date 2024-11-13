//
//  ProductCheckCell.swift
//  Speedo
//
//  Created by mac on 17/06/21.
//

import UIKit

class ProductCheckCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    var cloCheck:((_ isCheck: Bool)->Void)?
    
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
}
