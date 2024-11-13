//
//  OrderCell.swift
//  Speedo
//
//  Created by mac on 20/04/21.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblExtraItem: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var btnReorder: UIButton!
    @IBOutlet weak var btnTrackOrder: UIButton!
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var subTotalVw: UIView!
    @IBOutlet weak var totalVw: UIView!
    
    var cloTrackOrder:(()->Void)?
    var cloReorder:(()->Void)?
    var cloPrint:(() ->Void)?
    var arrCartDetails: [ResCartDetail] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tblVw.register(UINib(nibName: "ExtraItemCell", bundle: nil), forCellReuseIdentifier: "ExtraItemCell")
        self.tblVw.dataSource = self
        self.tblVw.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindItems(arr: [ResCartDetail]) {
        self.arrCartDetails = arr
        var heightRow:CGFloat = 0.0
        for val in arr {
            let font = UIFont(name: "Arial", size: 13.0) ?? .systemFont(ofSize: 13)
            let height = heightForView(text: val.extraItemName ?? "", font: font, width: self.tblVw.frame.width)
            let tempRowHeight = 60.0 + height
            heightRow = heightRow + tempRowHeight
        }
        self.tblHeight.constant = heightRow
        self.tblVw.reloadData()
        print(self.arrCartDetails)
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
    
    
    @IBAction func btnTrackOrder(_ sender: UIButton) {
        self.cloTrackOrder?()
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        self.cloReorder?()
    }
    
    @IBAction func btnPrint(_ sender: UIButton) {
        self.cloPrint?()
    }
}

extension OrderCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCartDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExtraItemCell", for: indexPath) as! ExtraItemCell
        let obj = self.arrCartDetails[indexPath.row]
        cell.lblItemName.text = "\(obj.quantity ?? "") x \(obj.productName ?? "") (\(obj.sizeName ?? ""))"
        if let name = obj.extraItemName, name != "" {
            cell.lblExtraItem.text = obj.extraItemName ?? ""
        } else {
            cell.lblExtraItem.text = "NA"
        }
        return cell
    }
}

extension OrderCell: UITableViewDelegate {
   
}
