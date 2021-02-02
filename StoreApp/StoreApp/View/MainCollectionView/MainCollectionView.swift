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
    let networkManager = NetworkManager()
    
    func initView() {
        
        getData()
        self.delegate = self
        self.dataSource = self
        setLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(addItemData), name: Notification.Name("getItemData"), object: nil)
        
    }
    
    func getData() {
        
        networkManager.getItemData(category: "best")
        networkManager.getItemData(category: "mask")
        networkManager.getItemData(category: "grocery")
        networkManager.getItemData(category: "fryingpan")
        
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
    
    @objc func addItemData(_ notification: Notification) {
        
        let jsonData = notification.object as! JsonData
        switch jsonData.category {
        case "best":
            for storeItem in jsonData.storeItems {
                self.storeItems.bests.append(storeItem)
            }
        case "mask":
            for storeItem in jsonData.storeItems {
                self.storeItems.masks.append(storeItem)
            }
        case "grocery":
            for storeItem in jsonData.storeItems {
                self.storeItems.grocerys.append(storeItem)
            }
        case "fryingpan":
            for storeItem in jsonData.storeItems {
                self.storeItems.fryingpans.append(storeItem)
            }
        default:
            self.reloadData()
        }
        self.reloadData()
    }
    
}

extension MainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("HI")
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
        print("god")
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

    
}
