//
//  SearchLocationCell.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import UIKit

class SearchLocationCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblMainLocation: UILabel!
    @IBOutlet weak var lblSecondaryLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

