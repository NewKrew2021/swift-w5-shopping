//
//  DetailViewController.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/05.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var parentView: UIView!
    var networkManager = NetworkManager()
    var storeItem: StoreItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getDetailData(storeItem: storeItem!)
        NotificationCenter.default.addObserver(self, selector: #selector(parseDetailData), name: Notification.Name("getDetailData"), object: nil)
    }
    
    @objc func parseDetailData(_ notification: Notification) {
        
        let jsonData = notification.object as! Data        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(StoreItemDetail.self, from: jsonData) else { return }
        
    }

}
