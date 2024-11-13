//
//  LeftSideMenuVC.swift
//  Speedo
//
//  Created by mac on 18/04/21.
//

import UIKit
import SlideMenuControllerSwift

enum LeftMenu: Int {
    case home = 0
    case myProfile
    case restuarantInfo
//    case myReview
    case changeLanguage    
    case terms
    case logout
}

class LeftSideMenuVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    
    var menuArrName = [
        R.string.localizable.home(),
        R.string.localizable.myProfile(),
        R.string.localizable.restaurantInformation(),
//        R.string.localizable.myReviews(),
        R.string.localizable.changeLanguage(),
        R.string.localizable.termsAndCondition(),
        R.string.localizable.logout()
    ]
    
    var arrImage = [
        R.image.ic_02(),
        R.image.ic_02(),
        R.image.ic_02(),
//        R.image.ic_03(),
        R.image.ic_04(),
        R.image.ic_05(),
        R.image.ic_06(),
        R.image.ic_07()
    ]
    
    var homeMain:UIViewController!
    var leftMenu:UIViewController!
    var homeViewController: UIViewController!
    var restaurantInfoViewController: UIViewController!
    var myProfileViewController: UIViewController!
    var changeLangViewController: UIViewController!
//    var myReviewsViewController: UIViewController!
    var TermsAndCondViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeMain = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
        self.leftMenu = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
        self.tableViewOt.register(UINib(nibName: "LeftSideMenu", bundle: nil), forCellReuseIdentifier: "LeftSideMenu")
        self.tableViewOt.tableFooterView = UIView(frame: CGRect.zero)
        
        let objHomeVC = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
        self.homeViewController = UINavigationController(rootViewController: objHomeVC)
        
        let objMyProfileVC = R.storyboard.main().instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        objMyProfileVC.comingFrom = "User"
        self.myProfileViewController = UINavigationController(rootViewController: objMyProfileVC)
        
        let objRestaurantInfoVC = R.storyboard.main().instantiateViewController(withIdentifier: "RestaurantInfoVC") as! RestaurantInfoVC
        self.restaurantInfoViewController = UINavigationController(rootViewController: objRestaurantInfoVC)
        
        let objChangeLanguageVC = R.storyboard.main().instantiateViewController(withIdentifier: "ChangeLanguageVC") as! ChangeLanguageVC
        self.changeLangViewController = UINavigationController(rootViewController: objChangeLanguageVC)
        
//        let objMyReviewsVC = R.storyboard.main().instantiateViewController(withIdentifier: "MyReviewsVC") as! MyReviewsVC
//        objMyReviewsVC.comingFrom = "user"
//        self.myReviewsViewController = UINavigationController(rootViewController: objMyReviewsVC)
        
        let objTermsAndCondVC = R.storyboard.main().instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
        self.TermsAndCondViewController = UINavigationController(rootViewController: objTermsAndCondVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        if Utility.isUserLogin() {
            self.lblProfileName.text = k.userDefault.value(forKey: k.session.userName) as? String
        } else {
            self.lblProfileName.text = "Guest User"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func changeController(_ index: Int) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
        vc.indexSelect = index
        let rootVC = SlideMenuController(mainViewController: vc, leftMenuViewController: self.leftMenu)
        kAppDelegate.window?.rootViewController = rootVC
        kAppDelegate.window?.makeKeyAndVisible()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.changeController(0)
        case .myProfile:
            if Utility.isUserLogin() {
                self.slideMenuController()?.changeMainViewController(self.myProfileViewController, close: true)
            } else {
                Utility.showAlertRegistration(parentViewController: self) { (bool) in
                    if bool {
                        Utility.logoutt()
                    }
                }
            }
        case .restuarantInfo:
            if Utility.isUserLogin() {
                self.slideMenuController()?.changeMainViewController(self.restaurantInfoViewController, close: true)
            } else {
                Utility.showAlertRegistration(parentViewController: self) { (bool) in
                    if bool {
                        Utility.logoutt()
                    }
                }
            }
//        case .myReview:
//            if Utility.isUserLogin() {
//                self.slideMenuController()?.changeMainViewController(self.myReviewsViewController, close: true)
//            } else {
//                Utility.showAlertRegistration(parentViewController: self) { (bool) in
//                    if bool {
//                        Utility.logoutt()
//                    }
//                }
//            }
        case .changeLanguage:
            self.slideMenuController()?.changeMainViewController(self.changeLangViewController, close: true)
        case .terms:
            self.slideMenuController()?.changeMainViewController(self.TermsAndCondViewController, close: true)
        case .logout:
            self.logout()
        }
    }
    
    func doShare() {
        if let url = URL(string: "https://play.google.com/store/apps/details?id=main.com.hungrilahfood"), !url.absoluteString.isEmpty {
            let shareText = "https://play.google.com/store/apps/details?id=main.com.hungrilahfood"
            let shareItems: [Any] = [shareText, url]
            
            let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .postToFlickr, .assignToContact, .openInIBooks]
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func whatsapp() {
        let urlWhats = "whatsapp://send?phone=+966558885707&text="
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.insert(charactersIn: "?&")
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet){
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL){
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        self.logout()
    }
    
    func logout() {
        let alertController = UIAlertController(title: k.appName, message: R.string.localizable.areYouSureYouWantToLogOut(), preferredStyle: .alert)
        let yesAction: UIAlertAction = UIAlertAction(title: R.string.localizable.yes(), style: .default) { action -> Void in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
            L102Language.setAppleLAnguageTo(lang: "en")
            Switcher.updateRootVC()
        }
        let noAction: UIAlertAction = UIAlertAction(title: R.string.localizable.no(), style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LeftSideMenuVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.leftSideMenu, for: indexPath)!
        cell.lbl.text = menuArrName[indexPath.row]
        cell.img.image = self.arrImage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension LeftSideMenuVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        k.userDefault.set(false, forKey: k.session.catShortCode)
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
}
