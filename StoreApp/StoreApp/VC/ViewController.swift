//
//  ViewController.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {
    
    @IBOutlet weak var myShoppingCollectionView: UICollectionView!
    
    private var cellwidth = UIScreen.main.bounds.width
    private var cellheight = UIScreen.main.bounds.height/3
    var item = StoreItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myShoppingCollectionView.delegate = self
        myShoppingCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItems(notification:)), name: NSNotification.Name("reloadItem"), object: nil)
        
        setLayout()
        initNavigationBar()
    }
    
    func setLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        myShoppingCollectionView.collectionViewLayout = flowLayout
        
        let layout = myShoppingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
    }
    
    @objc func reloadItems(notification: Notification) {
        myShoppingCollectionView.reloadData()
    }
    
    func initNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "카카오 쇼핑"
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.allItems[JsonFileName.jsonFileName[section]]!.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return item.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        cell.setSubViews(indexPath: indexPath, data: item.allItems)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellwidth*0.7, height: cellwidth*0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reuseView", for: indexPath) as! myCollectionReusableView
            headerView.setHeader(indexPath: indexPath)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = item.allItems[JsonFileName.jsonFileName[indexPath[0]]]![indexPath[1]].productName
        var price : String = ""
        if let dc = item.allItems[JsonFileName.jsonFileName[indexPath[0]]]![indexPath[1]].groupDiscountedPrice {
            price = String(dc) + "원"
        }
        if let dc = item.allItems[JsonFileName.jsonFileName[indexPath[0]]]![indexPath[1]].originalPrice{
            price = String(dc) + "원"
        }
        
        let toast = Toast(text: item.allItems[JsonFileName.jsonFileName[indexPath[0]]]![indexPath[1]].productName + "\n" + price)
        ToastView.appearance().font = UIFont.systemFont(ofSize: 13, weight: .bold)
        toast.show()
    }
    
}
