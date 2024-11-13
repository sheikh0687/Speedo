//
//  RestAvailableDriverVC.swift
//  Speedo
//
//  Created by mac on 08/09/21.
//

import UIKit

class RestAvailableDriverVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "AvailableDriverCell"
    var arr:[ResRestAvailableDriver] = []
    var orderId = ""
    var cloRefresh:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.availableDriver(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getRestAvailableDriver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getRestAvailableDriver() {
        print(self.paramRestAvailableDriver())
        Api.shared.restAvailableDriver(self, self.paramRestAvailableDriver()) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramRestAvailableDriver() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["rest_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["lat"] = k.userDefault.value(forKey: k.session.lat) as AnyObject
        dict["lon"] = k.userDefault.value(forKey: k.session.lon) as AnyObject
        return dict
    }
    
    func restAssignDriver(_ driverId: String) {
        print(self.paramAssignDriver(driverId))
        Api.shared.restAssignDriver(self, self.paramAssignDriver(driverId)) { (response) in
            self.cloRefresh?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func paramAssignDriver(_ driverId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["order_id"] = self.orderId as AnyObject
        dict["driver_id"] = driverId as AnyObject
        return dict
    }
}

extension RestAvailableDriverVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.availableDriverCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblName.text = obj.firstName ?? ""
        cell.lblStatus.text = obj.availableStatus ?? ""
        cell.lblDistance.text = "\(obj.distance ?? "") \(R.string.localizable.kmAway())"
        if let rate = obj.avgRating, rate != "" {
            let rat = Double(rate) ?? 0.0
            cell.vwRating.rating = rat
        }
        
        cell.cloClickToAssign = {() in
            self.restAssignDriver(obj.id ?? "")
        }
        return cell
    }
}
