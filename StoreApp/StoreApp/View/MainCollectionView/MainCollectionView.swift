//
//  MainCollectionView.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import UIKit

class MainCollectionView: UICollectionView {
    
    var storeItems = StoreItems()

    func initView() {
        
    }
    
}

extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell        
        return cell
        
    }
    
}
