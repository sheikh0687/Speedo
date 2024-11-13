//
//  ResChooseTimeVC.swift
//  Speedo
//
//  Created by mac on 07/09/21.
//

import UIKit

class ResChooseTimeVC: UIViewController {

    @IBOutlet weak var collectionViewOt: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var identifier = "RestChooseTimeCell"
    var arr = [
        "01:00","02:00","03:00","04:00",
        "05:00","06:00","07:00","08:00",
        "09:00","10:00","11:00","12:00",
        "13:00","14:00","15:00","16:00",
        "17:00","18:00","19:00","20:00",
        "21:00","22:00","23:00","24:00"
    ]
    
    var cloSelect:((_ time: String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewOt.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}

extension ResChooseTimeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.restChooseTimeCell, for: indexPath)!
        cell.lblTime.text = self.arr[indexPath.row]
        return cell
    }
}

extension ResChooseTimeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.cloSelect?(self.arr[indexPath.row])
        }
    }
}

extension ResChooseTimeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewOt.frame.width / 4, height: 30)
    }
}
