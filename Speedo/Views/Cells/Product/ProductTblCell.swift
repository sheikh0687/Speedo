//
//  ProductTblCell.swift
//  Speedo
//
//  Created by mac on 03/08/21.
//

import UIKit

class ProductTblCell: UITableViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnFavouriteStatus: UIButton!
    
    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var lblRestName: UILabel!
    @IBOutlet weak var lblRestDesc: UILabel!
    @IBOutlet weak var lblRestLocation: UILabel!
    @IBOutlet weak var lblRestStatus: UILabel!
    
    var cloFavourite:(()->Void)?
    var cloAdd:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnFavourite(_ sender: UIButton) {
        self.cloFavourite?()
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        self.cloAdd?()
    }
    
}
