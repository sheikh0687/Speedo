//
//  RestaurantReviewCell.swift
//  Speedo
//
//  Created by mac on 19/04/21.
//

import UIKit
import Cosmos

class RestaurantReviewCell: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
