//
//  ViewController.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import UIKit

// MARK: - MainViewController

class MainViewController: UIViewController {
    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        addObserver()
        getItems()
    }

    @objc func didReceiveItemsNotification(_ noti: Notification) {
        guard let items: [Item] = noti.userInfo?["Items"] as? [Item] else {
            return
        }
        print(items)
        viewModel.addItems(items: items)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }

    // MARK: Private

    private let imageCache = NSCache<NSString, UIImage>()

    private let viewModel = MainViewModel()
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

    private func getItems() {
        for type in ItemType.allCases {
            Request.shared.requestItem(type: type.getString())
        }
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveItemsNotification(_:)), name: DidReceiveItemsNotification, object: nil)
    }
}

extension MainViewController {
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 2 ? viewModel.items.count : 4
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: key_itemCell, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }

        let data = viewModel.items[indexPath.section][indexPath.item]
        if let cacheImage = imageCache.object(forKey: data.imageUrl as NSString) {
            cell.updateImage(img: cacheImage)
            cell.updateUI(title: data.name, talkDealPrice: data.price ?? 0, price: data.originalPrice, numberOfParticipant: data.numberOfParticipant ?? 0)
            
        } else {
            // 캐시된 이미지가 없음
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                guard let imageUrl = URL(string: data.imageUrl) else { return }
                guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                let image = UIImage(data: imageData) ?? UIImage()
                self.imageCache.setObject(image, forKey: data.imageUrl as NSString)

                DispatchQueue.main.async {
                    cell.updateImage(img: image)
                    cell.updateUI(
                        title: data.name,
                        talkDealPrice: data.price ?? 0,
                        price: data.originalPrice,
                        numberOfParticipant: data.numberOfParticipant ?? 0)
                }
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}

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

extension MainViewController: UICollectionViewDelegateFlowLayout {
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
