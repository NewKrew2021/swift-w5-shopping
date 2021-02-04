//
//  MainCollectionView.swift
//  StoreApp
//
//  Created by herb.salt on 2021/02/02.
//  Copyright © 2021 com.kakaocorp. All rights reserved.
//

import UIKit

protocol SendStoreItemDataDelegate {
    func sendData(storeItem: StoreItem?)
}

class MainCollectionView: UICollectionView {
    
    var storeItems = StoreItems()
    var sendStoreItemDataDelegate: SendStoreItemDataDelegate?
    
    func initView() {
        
        self.delegate = self
        self.dataSource = self
        setLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("reloadCollectionView"), object: nil)
        
    }
    
    func setLayout() {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.9))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        self.collectionViewLayout = layout
        
    }
    
    @objc func reloadCollectionView(_ notification: Notification) {
        self.reloadData()
    }
    
}

extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return storeItems.bests.count
        case 1:
            return storeItems.masks.count
        case 2:
            return storeItems.grocerys.count
        case 3:
            return storeItems.fryingpans.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell.makeCell(storeItems.bests[indexPath.row])
        case 1:
            cell.makeCell(storeItems.masks[indexPath.row])
        case 2:
            cell.makeCell(storeItems.grocerys[indexPath.row])
        case 3:
            cell.makeCell(storeItems.fryingpans[indexPath.row])
        default:
            return cell
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MainCollectionHeaderCell", for: indexPath) as! MainCollectionHeaderCell
        guard kind == UICollectionView.elementKindSectionHeader else {return header}
        switch indexPath.section {
        case 0:
            header.headerLabel.text = "베스트"
        case 1:
            header.headerLabel.text = "마스크"
        case 2:
            header.headerLabel.text = "식료품"
        case 3:
            header.headerLabel.text = "프라이팬"
        default:
            return header
        }
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 20
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var sotreItemToDeliever: StoreItem?
        switch indexPath.section {
        case 0:
            sotreItemToDeliever = storeItems.bests[indexPath.row]
        case 1:
            sotreItemToDeliever = storeItems.masks[indexPath.row]
        case 2:
            sotreItemToDeliever = storeItems.grocerys[indexPath.row]
        case 3:
            sotreItemToDeliever = storeItems.fryingpans[indexPath.row]
        default:
            sotreItemToDeliever = nil
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "delieverSelectedData"), object: storeItems.bests[0])
    }

    
}
