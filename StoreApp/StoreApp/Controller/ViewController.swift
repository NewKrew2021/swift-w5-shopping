//
//  ViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import UIKit
import Toaster

class ViewController: UIViewController {
    
    private let request = Request()
    private var products: [[Product]] = Array(repeating: [Product](), count: 4)
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        view.register(UINib(nibName: "ShoppingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ShoppingCollectionViewCell")
        view.register(UINib(nibName: "ShoppingCollectionReusableView", bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ShoppingCollectionReusableView")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                    selector: #selector(completedJsonParsing),
                    name: NSNotification.Name(rawValue: "jsonParsing"),
                    object: nil)
        
        addCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for productType in ProductType.allCases {
            request.request(productType: productType)
        }
    }
    
    func addCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func completedJsonParsing(_ notification:Notification) {
        self.products[(notification.userInfo?["productType"] as! ProductType).rawValue] = notification.userInfo?["products"] as! [Product]
        self.collectionView.reloadData()
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCollectionViewCell", for: indexPath) as! ShoppingCollectionViewCell
        
        cell.setViewData(productName: products[indexPath.section][indexPath.row].productName, productImage: self.products[indexPath.section][indexPath.row].productImage, groupDiscountedPrice: self.products[indexPath.section][indexPath.row].groupDiscountedPrice ?? -1, originalPrice: self.products[indexPath.section][indexPath.row].originalPrice, groupDiscountUserCount: self.products[indexPath.section][indexPath.row].groupDiscountUserCount ?? -1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.size.width
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ShoppingCollectionReusableView", for: indexPath) as! ShoppingCollectionReusableView
            headerView.setViewData(productType: ProductType(rawValue: indexPath.section) ?? .best)
            return headerView
        default:
            assert(false, "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.section][indexPath.row]
        let toast = Toast(text: "\(product.productName) \(product.groupDiscountedPrice ?? product.originalPrice)원")
        toast.show()
    }
}
