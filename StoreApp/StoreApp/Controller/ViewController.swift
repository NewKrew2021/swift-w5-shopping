//
//  ViewController.swift
//  StoreApp
//
//  Created by 이청원 on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {
    
    private let request = Request()
    private var products = [Product]()
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        view.register(UINib(nibName: "ShoppingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ShoppingCollectionViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
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
        
        request.request(productType: .best)
    }
    
    func addCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func completedJsonParsing(_ notification:Notification) {
        self.products = notification.userInfo?["products"] as! [Product]
        print(products)
//        collectionView.reloadData()
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCollectionViewCell", for: indexPath) as! ShoppingCollectionViewCell
        
        cell.backgroundColor = .green
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.size.width
        return CGSize(width: width, height: width)
    }
}
