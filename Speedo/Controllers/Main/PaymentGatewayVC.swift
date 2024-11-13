//
//  PaymentGatewayVC.swift
//  Speedo
//
//  Created by mac on 16/11/21.
//

import UIKit
import WebKit

class PaymentGatewayVC: UIViewController {

    var paymentGatewayUrl = ""
    var orderId = ""
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: paymentGatewayUrl)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true, block: { _ in
            self.checkPaymentGateway()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func checkPaymentGateway() {
        Api.shared.checkPaymentGateway(self, self.paramCheckPaymentGateway()) { (response) in
            if let status = response.status, status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.orderPlacedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                    Switcher.updateRootVC()
                }
            }
        }
    }
    
    func paramCheckPaymentGateway() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["order_id"] = self.orderId as AnyObject
        dict["transaction_id"] = k.emptyString as AnyObject
        return dict
    }
}

extension PaymentGatewayVC: WKNavigationDelegate {
    
    
}
