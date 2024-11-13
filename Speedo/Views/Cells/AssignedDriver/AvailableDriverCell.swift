//
//  AvailableDriverCell.swift
//  Speedo
//
//  Created by mac on 08/09/21.
//

import UIKit
import Cosmos

class AvailableDriverCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    
    var cloClickToAssign:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func btnClickToAssign(_ sender: UIButton) {
        self.cloClickToAssign?()
    }
}
