//
//  ViewController.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }

    // MARK: Private

    private let key_itemCell = "ItemCollectionViewCell"
    private let key_header = "ItemHeaderView"
    private let request = Request.shared

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white

        return cv
    }()
}

extension ViewController {
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: key_itemCell, bundle: nil), forCellWithReuseIdentifier: key_itemCell)
        collectionView.register(UINib(nibName: key_header, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: key_header)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: key_itemCell, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }

        cell.updateUI(img: UIImage(systemName: "heart.fill") ?? UIImage(), title: "타이틀", talkDealPrice: 10000, price: 10000, numberOfParticipant: 100)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: key_header, for: indexPath)
            return header
        default:
            assert(false, "Should implement another case")
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.7
        let height = width * 10 / 7

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height = CGFloat(40)

        return CGSize(width: width, height: height)
    }
}
