//
//  MyReviewsVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit

class MyReviewsVC: UIViewController {
    
    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "RestaurantReviewCell"
    
    var arr:[ResDrvRatingList] = []
    
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.myReviews(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        if comingFrom == "Driver" {
            self.getGetDrvRatingList()
        } else if comingFrom == "user" {
            self.getRatingList()
        } else {
            self.getGetRestRatingList()
        }
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getGetDrvRatingList() {
        Api.shared.drvGetRatingList(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func getGetRestRatingList() {
        Api.shared.getRestReviewList(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func getRatingList() {
        Api.shared.getRatingList(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
}

extension MyReviewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.restaurantReviewCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblDesc.text = obj.review ?? ""
        if comingFrom == "Driver" {
            cell.lblName.text = obj.userName ?? ""
        } else {
            cell.lblName.text = obj.userName ?? ""
        }
        cell.lblDate.text = obj.dateTime ?? ""
        if let rate = obj.rating, rate != "" {
            cell.vwCosmos.rating = Double(rate) ?? 0.0
        } else {
            cell.vwCosmos.rating = 0.0
        }
        return cell
    }
}
