//
//  ProductRadioCell.swift
//  Speedo
//
//  Created by mac on 17/06/21.
//

import UIKit

class ProductRadioCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    var cloCheck:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnCheck.setImage(R.image.radio_uncheck(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCheck(_ sender: UIButton) {
        self.btnCheck.setImage(R.image.radio_check(), for: .normal)
        self.cloCheck?()
    }
}
