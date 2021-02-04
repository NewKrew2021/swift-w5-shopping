//
//  ViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {
    
    private let network = Network()
    private var products: [[Product]] = Array(repeating: [Product](), count: 4)
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        view.register(UINib(nibName: "ShoppingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ShoppingCollectionViewCell")
        view.register(UINib(nibName: "ShoppingCollectionReusableView", bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ShoppingCollectionReusableView")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        if let collectionViewLayout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
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
        
        network.getProductData()
    }
    
    func addCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func completedJsonParsing(_ notification:Notification) {
        DispatchQueue.main.async {
            self.products[notification.userInfo?["productTypeValue"] as! Int] = notification.userInfo?["products"] as! [Product]
            self.collectionView.reloadData()
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCollectionViewCell", for: indexPath) as! ShoppingCollectionViewCell
        
        cell.setViewData(product: self.products[indexPath.section][indexPath.row])
        
        return cell
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
        self.performSegue(withIdentifier: "productSegue", sender: product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productSegue" {
            let productVC = segue.destination as! ProductViewController
            let product = sender as! Product
            productVC.product = product
        }
    }
}
