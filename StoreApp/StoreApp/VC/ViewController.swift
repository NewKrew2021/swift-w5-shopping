//
//  ViewController.swift
//  StoreApp
//
//  Created by 이준형 on 2021/02/01.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myShoppingCollectionView: UICollectionView!
    
    private var cellwidth = UIScreen.main.bounds.width
    private var cellheight = UIScreen.main.bounds.height/2
    var item = StoreItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        myShoppingCollectionView.collectionViewLayout = flowLayout
        myShoppingCollectionView.delegate = self
        myShoppingCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItems(notification:)), name: NSNotification.Name("reloadItem"), object: nil)
        
        initNavigationBar()
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
        return item[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return item.allItems.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        cell.setSubViews(indexPath: indexPath, data: item.allItems)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellwidth, height: cellheight)
    }
    
}
