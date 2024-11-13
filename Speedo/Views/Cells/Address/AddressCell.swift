//
//  AddressCell.swift
//  Facility
//
//  Created by mac on 01/06/21.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var cloDelete:(()->Void)?
    var cloSelect:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloDelete?()
    }
    
    @IBAction func btnSelect(_ sender: UIButton) {
        self.cloSelect?()
    }
}
