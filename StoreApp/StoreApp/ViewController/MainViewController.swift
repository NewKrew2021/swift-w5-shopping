//
//  MainViewController.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/01.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: MainCollectionView!
    var networkManager = NetworkManager()
    var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getData()
    }
    
    func initView() {       
        mainCollectionView.initView()
        mainCollectionView.storeItems = self.storeItems
        NotificationCenter.default.addObserver(self, selector: #selector(addItemData), name: Notification.Name("getItemData"), object: nil)
    }
    
    func getData() {
        
        networkManager.getItemData(category: "best")
        networkManager.getItemData(category: "mask")
        networkManager.getItemData(category: "grocery")
        networkManager.getItemData(category: "fryingpan")
        
    }
    
    @objc func addItemData(_ notification: Notification) {
        
        let jsonData = notification.object as! Data
        guard let category = notification.userInfo?["category"] as? String else { return }
        
        let decoder = JSONDecoder()
        guard let results = try? decoder.decode([StoreItem].self, from: jsonData) else { return }
        
        self.storeItems.addData(category: category, items: results)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadCollectionView"), object: nil)
        
    }

}
