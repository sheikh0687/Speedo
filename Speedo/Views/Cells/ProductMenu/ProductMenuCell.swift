//
//  ProductMenuCell.swift
//  Speedo
//
//  Created by mac on 19/04/21.
//

import UIKit

class ProductMenuCell: UITableViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var cloAdd:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
    }
}
