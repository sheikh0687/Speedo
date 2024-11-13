//
//  TopRatedCell.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit
import Cosmos

class TopRatedCell: UICollectionViewCell {

    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblRestName: UILabel!
    @IBOutlet weak var lblSpeciality: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
