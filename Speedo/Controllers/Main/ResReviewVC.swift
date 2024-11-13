//
//  ReviewVC.swift
//  Speedo
//
//  Created by mac on 19/04/21.
//

import UIKit

class ResReviewVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "RestaurantReviewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension ResReviewVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.restaurantReviewCell, for: indexPath)!
        return cell
    }
}

extension ResReviewVC: UITableViewDelegate {
    
}
