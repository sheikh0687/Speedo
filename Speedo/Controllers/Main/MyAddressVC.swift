//
//  MyAddressVC.swift
//  Speedo
//
//  Created by mac on 11/08/21.
//

import UIKit

class MyAddressVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "AddressCell"
    var arr:[ResAddress] = []
    var cloSelect:((_ addressId: String, _ address: String, _ lat: String, _ lon: String, _ title: String)->Void)?
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.comingFrom == "placeorder" {
            setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.myAddress(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        } else {
            setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myAddress(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        }
        self.tabBarController?.tabBar.isHidden = true
        self.getAddress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func leftClick() {
        if self.comingFrom == "" {
            toggleLeft()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getAddress() {
        Api.shared.getAddress(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    @IBAction func btnAddNew(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { (a,b,c,d) in
            self.getAddress()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func paramDelete(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["address_id"] = id as AnyObject
        return dict
    }
    
    func delete(_ id: String) {
        print(self.paramDelete(id))
        Api.shared.deleteAddress(self, self.paramDelete(id)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.addressDeletedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.getAddress()
            }
        }
    }
}

extension MyAddressVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.addressCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblAddress.text = obj.address ?? ""
        cell.lblTitle.text = obj.title ?? ""
        cell.cloDelete = {() in
            self.delete(obj.id ?? "")
        }
        cell.cloSelect = {() in
            self.cloSelect?(obj.id ?? "", obj.address ?? "", obj.lat ?? "", obj.lon ?? "", obj.title ?? "")
            self.navigationController?.popViewController(animated: true)
        }
        return cell
    }
}

extension MyAddressVC: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}

