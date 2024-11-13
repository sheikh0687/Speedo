//
//  TopRatedRestVC.swift
//  Speedo
//
//  Created by mac on 20/05/21.
//

import UIKit

class TopRatedRestVC: UIViewController {

    @IBOutlet weak var clvTopRated: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var idenTopRated = "TopRatedCell"
    var arrTopRestaurant:[ResRestaurant] = []
    var arrOrgTopRestaurant:[ResRestaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsScopeBar = true
        self.searchBar.returnKeyType = .done
        print(k.userDefault.value(forKey: k.session.userId))
        self.clvTopRated.register(UINib(nibName: idenTopRated, bundle: nil), forCellWithReuseIdentifier: idenTopRated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.products(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.getTopRestaurant()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func paramTopRestaurant() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["rest_id"] = k.userDefault.value(forKey: k.session.interestedRestId) as AnyObject
        dict["timezone"] = localTimeZoneIdentifier as AnyObject
        dict["size"] = k.emptyString as AnyObject
        dict["now_current_day"] = Utility.getCurrentDay() as AnyObject
        return dict
    }
    
    func getTopRestaurant() {
        Api.shared.getTopRestaurantList(self, self.paramTopRestaurant()) { (response) in
            if response.count > 0 {
                self.arrTopRestaurant = response
                self.arrOrgTopRestaurant = response
            } else {
                self.arrTopRestaurant = []
                self.arrOrgTopRestaurant = []
            }
            self.clvTopRated.reloadData()
        }
    }
}

extension TopRatedRestVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrTopRestaurant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.topRatedCell, for: indexPath)!
        let obj = self.arrTopRestaurant[indexPath.row]
        cell.lblRestName.text = obj.restName ?? ""
        if let coverImage = obj.restCoverImage, coverImage != Router.BASE_IMAGE_URL {
            Utility.setImageWithSDWebImage(coverImage, cell.imgRest)
        }
        if let restImage = obj.restImage, restImage != Router.BASE_IMAGE_URL {
            Utility.setImageWithSDWebImage(restImage, cell.imgDish)
        }
        cell.lblStatus.text = obj.restOpenStatus ?? ""
        if let status = obj.restOpenStatus, status == "CLOSE" {
            cell.lblStatus.backgroundColor = .red
        }
        cell.lblSpeciality.text = obj.aboutMe ?? ""
        return cell
    }
}

extension TopRatedRestVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 30, height: 260)
    }
}

extension TopRatedRestVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "RestaurantMenuVC") as! RestaurantMenuVC
        vc.objRest = self.arrTopRestaurant[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopRatedRestVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arrTopRestaurant = self.arrOrgTopRestaurant
        if searchText != "" {
            let filteredArr = self.arrTopRestaurant.filter({ $0.restName?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil })
            self.arrTopRestaurant = filteredArr
        }
        self.clvTopRated.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
