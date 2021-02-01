//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var shoppingCollectionView: UICollectionView!
    var productCollectionView = ProductCollcetionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.calculateSize(width: nil)
        shoppingCollectionView.delegate = productCollectionView
        shoppingCollectionView.dataSource = productCollectionView

        let urls = ["http://public.codesquad.kr/jk/kakao-2021/best.json", "http://public.codesquad.kr/jk/kakao-2021/mask.json", "http://public.codesquad.kr/jk/kakao-2021/grocery.json", "http://public.codesquad.kr/jk/kakao-2021/flyingpan.json"]

        NetworkHandler.getData(resource: urls[0])
    }
}
