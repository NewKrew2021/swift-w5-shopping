//
//  ViewController.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/01.
//

import Toaster
import UIKit

// MARK: - MainViewController

class MainViewController: UIViewController {
    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        print(123)
        setCollectionView()
        addObserver()
        title = "카카오 쇼핑"
    }

    @objc func didReceiveItemsNotification(_ noti: Notification) {
        guard let items: [Item] = noti.userInfo?["Items"] as? [Item] else { return }
        viewModel.addItems(items: items)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }

    @objc func didReceiveDetaileNotification(_ noti: Notification) {
        guard let detail: Detail = noti.userInfo?["Detail"] as? Detail else { return }
        print(detail)
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

    private func getItems(index: Int) {
        guard let type = ItemType(rawValue: index)?.getString() else { return }
        Request.shared.requestItem(type: type)
        viewModel.flags[index] = true
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveItemsNotification(_:)), name: Request.DidReceiveItemsNotification, object: nil)

//        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveImageNotification(_:)), name: Request.DidReceiveImageNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDetaileNotification(_:)), name: Request.DidReceiveDetailNotification, object: nil)
    }
}

// MARK: MainViewController UI

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

// MARK: UICollectionViewDelegate

//
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel[indexPath.section, indexPath.item]
        let name = item.name
        let price = item.originalPrice
        let detailVC = DetailViewController()
        detailVC.title = item.storeName

        request.requestDetail(storeDomain: item.storeDomain, productId: item.id) { detail, error in
            detailVC.viewModel.detail = detail
            
            DispatchQueue.main.async {[weak self] in
                Toast(text: "상품명 : \(name)\n가격 : \(price)원", delay: 0, duration: 1.0).show()
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items[section].count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: key_itemCell, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }

        let item = viewModel[indexPath.section, indexPath.item]
        if let url = URL(string: item.imageUrl) {
            // url을 통해 캐시를 확인한 후에 이미지 불러오기
            Request.shared.loadImageByCache(url: url) { image, _ in
                DispatchQueue.main.async {
                    cell.update(img: image ?? UIImage())
                }
            }
        }

        if item.hasTalkDeal() {
            cell.update(title: item.name,
                        price: item.originalPrice,
                        talkDealPrice: item.price ?? 0,
                        numberOfParticipant: item.numberOfParticipant ?? 0)
        } else {
            cell.update(title: item.name,
                        price: item.originalPrice)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: key_header, for: indexPath) as? ItemHeaderView else { return UICollectionReusableView() }
            header.sectionTitleLabel.text = ItemType(rawValue: indexPath.section)?.getString()
            return header
        default:
            assert(false, "Should implement another case")
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.8
        let height = width * 10 / 8

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height = CGFloat(40)

        return CGSize(width: width, height: height)
    }
}

// MARK: UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 컬렉션뷰 높이
        let height = collectionView.frame.size.height
        // 컬렉션뷰 현재 Y
        let offset_Y = collectionView.contentOffset.y
        // 현재높이 - Y
        let distanceFromBottom = collectionView.contentSize.height - offset_Y

        if distanceFromBottom < height {
            for section in 0 ..< viewModel.flags.count {
                if !viewModel.hasItems(at: section) {
                    print("getItem\(section)")
                    getItems(index: section)
                    break
                }
            }
        }
    }
}
