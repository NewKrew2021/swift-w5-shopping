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
    var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {       
        mainCollectionView.initView()
    }

}
