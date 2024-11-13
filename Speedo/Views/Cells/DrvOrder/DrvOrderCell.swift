//
//  DrvOrderCell.swift
//  Speedo
//
//  Created by mac on 03/05/21.
//

import UIKit

class DrvOrderCell: UITableViewCell {

    @IBOutlet weak var vwRatingStatus: UIView!
    @IBOutlet weak var vwUserDetail: UIView!
    @IBOutlet weak var btnSeeOnMap: UIButton!
    @IBOutlet weak var vwButtonStatus: UIView!
    @IBOutlet weak var vwNotifyUser: UIView!
    @IBOutlet weak var vwOrderDetail: UIView!
    @IBOutlet weak var constraintHeightRatingStatus: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewItemOt: UITableView!
    @IBOutlet weak var constraintHeightOt: NSLayoutConstraint!
    
    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var lblRest: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblRestStatus: UILabel!
    @IBOutlet weak var lblRestRating: UILabel!
    @IBOutlet weak var lblRestTotalAmount: UILabel!
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var btnDeliveryStatus: UIButton!
    @IBOutlet weak var vwDelivered: UIView!
    @IBOutlet weak var btnPrintBill: UIButton!
    
    var cloAccept:(()->Void)?
    var cloReject:(()->Void)?
    var cloNotifyUserToArrive:(()->Void)?
    var cloSeeOnMap:(()->Void)?
    var cloPrintBill:(()->Void)?
    
    var arrt:[ResCartDetail] = []
    var identifier = "ResOpenOrderItemCell"
    
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
            let tempRowHeight = 35.0 + height
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
    
    @IBAction func btnAccept(_ sender: UIButton) {
        self.cloAccept?()
    }
    
    @IBAction func btnReject(_ sender: UIButton) {
        self.cloReject?()
    }
    
    @IBAction func btnNotifyUserToArrived(_ sender: UIButton) {
        self.cloNotifyUserToArrive?()
    }
    
    @IBAction func btnSeeOnMap(_ sender: UIButton) {
        self.cloSeeOnMap?()
    }
    
    @IBAction func btnPrintBill(_ sender: UIButton) {
        self.cloPrintBill?()
    }
}


extension DrvOrderCell: UITableViewDataSource {
    
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

extension DrvOrderCell: UITableViewDelegate {
    
}
