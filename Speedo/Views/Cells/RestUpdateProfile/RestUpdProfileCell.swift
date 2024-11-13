//
//  RestUpdProfileCell.swift
//  Speedo
//
//  Created by mac on 07/09/21.
//

import UIKit

class RestUpdProfileCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var btnOpenTime: UIButton!
    @IBOutlet weak var btnCloseTime: UIButton!
    @IBOutlet weak var btnStatus: UIButton!
    
    var cloOpen:((_ status: String)->Void)?
    var cloOpenTime:(()->Void)?
    var cloCloseTime:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnStatus.backgroundColor = R.color.theme_color()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnOpen(_ sender: UIButton) {
        if btnStatus.backgroundColor == R.color.theme_color() {
            self.btnStatus.backgroundColor = .lightGray
            self.btnStatus.setTitle("CLOSE", for: .normal)
            self.cloOpen?("CLOSE")
        } else {
            self.btnStatus.backgroundColor = R.color.theme_color()
            self.btnStatus.setTitle("OPEN", for: .normal)
            self.cloOpen?("OPEN")
        }
    }
    
    @IBAction func btnOpenTime(_ sender: UIButton) {
        self.cloOpenTime?()
    }
    
    @IBAction func btnCloseTime(_ sender: UIButton) {
        self.cloCloseTime?()
    }
}
