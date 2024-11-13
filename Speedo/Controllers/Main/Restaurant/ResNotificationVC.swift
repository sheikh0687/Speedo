//
//  DrvNotificationVC.swift
//  Speedo
//
//  Created by mac on 21/04/21.
//

import UIKit

class ResNotificationVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var arr:[ResNotification] = []
    var identifier = "NotificationCell"
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.comingFrom == "user" {
            setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.notifications(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
            self.tabBarController?.tabBar.isHidden = true
        } else {
            setNavigationBarItem(LeftTitle: "", LeftImage: "menu", CenterTitle: R.string.localizable.notifications(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        }
        self.getNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func leftClick() {
        if self.comingFrom == "user" {
            self.navigationController?.popViewController(animated: true)
        } else {
            toggleLeft()
        }
    }
    
    func getNotification() {
        Api.shared.getNotificationList(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
}

extension ResNotificationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.notificationCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblTitle.text = obj.title ?? ""
        cell.lblDesc.text = obj.message ?? ""
        cell.lblDate.text = obj.date_time ?? ""
        return cell
    }
}
