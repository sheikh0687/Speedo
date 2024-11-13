//
//  ResOpenOrderCell.swift
//  Speedo
//
//  Created by mac on 28/04/21.
//

import UIKit

class ResOpenOrderCell: UITableViewCell {
    
    @IBOutlet weak var vwStatusButton: UIView!
    @IBOutlet weak var vwStatus: UIView!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var vwAssignedDriver: UIStackView!
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var tableViewItemOt: UITableView!
    @IBOutlet weak var constraintHeightOt: NSLayoutConstraint!
    @IBOutlet weak var lblItems: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    
    @IBOutlet weak var btnNotifyReady: UIButton!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDeliveryFees: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!    
    @IBOutlet weak var btnAssignedDriver: UIButton!
    @IBOutlet weak var vwDriverDetail: UIView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var imgDriver: UIImageView!
    
    var cloTakeOrder:(()->Void)?
    var cloCancelOrder:(()->Void)?
    var cloNotifyReady:(()->Void)?
    var cloPrint:(()->Void)?
    var cloAssignedDriver:(()->Void)?
    var cloCallDriver:(()->Void)?
    var cloItemNotAvailable:(()->Void)?
    
    var identifier = "ResOpenOrderItemCell"
    var arrt:[ResCartDetail] = []
    var widthTable = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableViewItemOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.tableViewItemOt.delegate = self
        self.tableViewItemOt.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindItems(arr: [ResCartDetail]) {
        self.arrt = arr
        var heightRow:CGFloat = 0.0
        for val in arr {
            let font = UIFont(name: "Arial", size: 13.0) ?? .systemFont(ofSize: 13)
            let height = heightForView(text: val.extraItemName ?? "", font: font, width: self.tableViewItemOt.frame.width)
            let tempRowHeight = 45.0 + height
            heightRow = heightRow + tempRowHeight
        }
        self.constraintHeightOt.constant = heightRow
        self.tableViewItemOt.reloadData()
        print(self.arrt)
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    @IBAction func btnTakeOrder(_ sender: UIButton) {
        self.cloTakeOrder?()
    }
    
    @IBAction func btnCancelOrder(_ sender: UIButton) {
        self.cloCancelOrder?()
    }
    
    @IBAction func btnNotifyReady(_ sender: UIButton) {
        self.cloNotifyReady?()
    }
    
    @IBAction func btnPrint(_ sender: UIButton) {
        self.cloPrint?()
    }
    
    @IBAction func btnAssignedDriver(_ sender: UIButton) {
        self.cloAssignedDriver?()
    }
    
    @IBAction func btnCallDriver(_ sender: UIButton) {
        self.cloCallDriver?()
    }
    
    @IBAction func btnItemNotAvailable(_ sender: UIButton) {
        self.cloItemNotAvailable?()
    }
}

extension ResOpenOrderCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.resOpenOrderItemCell, for: indexPath)!
        let obj = self.arrt[indexPath.row]
        cell.lblItem.text = "\(obj.quantity ?? "") x \(obj.productName ?? "") (\(obj.sizeName ?? ""))"
        if let name = obj.extraItemName, name != "" {
            cell.lblExtraItem.text = obj.extraItemName ?? ""
        } else {
            cell.lblExtraItem.text = "NA"
        }
        return cell
    }
}

extension ResOpenOrderCell: UITableViewDelegate {
    
}
