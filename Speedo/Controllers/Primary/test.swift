//
//  test.swift
//  Speedo
//
//  Created by mac on 09/02/22.
//

import UIKit

class test: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn(_ sender: Any) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PrimaryMainVC") as! PrimaryMainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
