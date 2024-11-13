//
//  ProductCell.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class ProductCell: UICollectionViewCell {

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
    }
    
    @IBAction func btnFavourite(_ sender: UIButton) {
        self.cloFavourite?()
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        self.cloAdd?()
    }
}
