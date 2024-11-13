//
//  ExtraItemCell.swift
//  Speedo
//
//  Created by Techimmense Software Solutions on 21/11/23.
//

import UIKit

class ExtraItemCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblExtraItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
