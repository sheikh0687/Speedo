//
//  ResTimeSelVC.swift
//  Speedo
//
//  Created by mac on 28/07/21.
//

import UIKit

class ResTimeSelVC: UIViewController {

    @IBOutlet weak var btn10Min: UIButton!
    @IBOutlet weak var btn15Min: UIButton!
    @IBOutlet weak var btn20Min: UIButton!
    @IBOutlet weak var btn30Min: UIButton!
    @IBOutlet weak var btn45Min: UIButton!
    @IBOutlet weak var btn1Hour: UIButton!
    
    var min = ""
    var cloSelectTime:((_ time: String)-> Void)?
    var cloAccept:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btn10Min(_ sender: UIButton) {
        self.min = "10"
        self.dismiss(animated: true) {
            self.cloSelectTime?("10 min")
        }
    }
    
    @IBAction func btn15Min(_ sender: UIButton) {
//        self.btn15Min.backgroundColor = R.color.theme_color()
//        self.btn30Min.backgroundColor = .clear
//        self.btn45Min.backgroundColor = .clear
//        self.btn1Hour.backgroundColor = .clear
        self.min = "15"
        self.dismiss(animated: true) {
            self.cloSelectTime?("15 min")
        }
    }
    
    @IBAction func btn20Min(_ sender: UIButton) {
        self.min = "20"
        self.dismiss(animated: true) {
            self.cloSelectTime?("20 min")
        }
    }
    
    
    @IBAction func btn30Min(_ sender: UIButton) {
//        self.btn15Min.backgroundColor = .clear
//        self.btn30Min.backgroundColor = .clear
//        self.btn45Min.backgroundColor = R.color.theme_color()
//        self.btn1Hour.backgroundColor = .clear
        self.min = "30"
        self.dismiss(animated: true) {
            self.cloSelectTime?("30 min")
        }        
    }
    
    @IBAction func btn45Min(_ sender: UIButton) {
//        self.btn15Min.backgroundColor = .clear
//        self.btn30Min.backgroundColor = .clear
//        self.btn45Min.backgroundColor = R.color.theme_color()
//        self.btn1Hour.backgroundColor = .clear
        self.min = "45"
        self.dismiss(animated: true) {
            self.cloSelectTime?("45 min")
        }
    }
    
    @IBAction func btn1Hr(_ sender: UIButton) {
//        self.btn15Min.backgroundColor = .clear
//        self.btn30Min.backgroundColor = .clear
//        self.btn45Min.backgroundColor = .clear
//        self.btn1Hour.backgroundColor = R.color.theme_color()
        self.min = "60"
        self.dismiss(animated: true) {
            self.cloSelectTime?("1 hour")
        }
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        self.cloAccept?()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
