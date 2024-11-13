//
//  MyEarningsVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class DrvMyEarningsVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "OfferCell"
    var arr:[ResMyEarning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myEarnings(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.getMyEarning()
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getMyEarning() {
//        Api.shared.getDriverEarnings(self) { (response) in
//            if response.count > 0 {
//                self.arr = response
//            } else {
//                self.arr = []
//            }
//            self.tableViewOt.reloadData()
//        }
    }
}

extension DrvMyEarningsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myEarningCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblTotal.text = "\(obj.totalAmount ?? "") \(k.currency)"
        cell.lblOrderDate.text = obj.date ?? ""
        cell.lblPickupAddress.text = obj.restDetails?.address ?? ""
        cell.lblDeliveryAddress.text = obj.addressDetails?.address ?? ""
        cell.lblDrivenKm.text = "\(obj.delKm ?? "") km"
        cell.lblDeliveryFee.text = "\(obj.driverDelFee ?? "") \(k.currency)"
        return cell
    }
}
