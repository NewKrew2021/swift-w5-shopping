//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/04.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: Internal

    let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addMainScrollView()
        addDetailScrollView()
        addReviewView()
        addTitleView()
        addBuyButton()
        scrollView.addImages(urls: viewModel.detail?.data.previewUrls ?? [])
    }

    // MARK: Private

    private var scrollView = DetailScrollView()
    private var mainScrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var starLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.text = "★ 3.5"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    private var reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.text = "리뷰 000건"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    private var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textContainer.maximumNumberOfLines = 2
        textView.text = "[모든 부자재 100% 국내산] 4중구조 KF94 황사마스크 성인용 100매"
        textView.textColor = .black
        return textView
    }()
    
    private var buyImmediately: EllipseButton = {
        let button = EllipseButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.4, height: 60))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("바로구매 00원", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.tintColor = .black
        return button
    }()
    
    private var buyDeal: EllipseButton = {
        let button = EllipseButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.4, height: 60))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("톡딜가 00원", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .yellow
        button.tintColor = .yellow
        return button
    }()

    private func addMainScrollView() {
        view.addSubview(mainScrollView)
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func addDetailScrollView() {
        mainScrollView.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func addReviewView() {
        mainScrollView.addSubview(starLabel)
        mainScrollView.addSubview(reviewLabel)
        starLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
        reviewLabel.topAnchor.constraint(equalTo: starLabel.topAnchor).isActive = true
        starLabel.trailingAnchor.constraint(equalTo: reviewLabel.leadingAnchor, constant: -20).isActive = true
        reviewLabel.centerXAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.centerXAnchor, constant: 30).isActive = true
    }
    
    private func addTitleView() {
        mainScrollView.addSubview(titleTextView)
        titleTextView.widthAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        titleTextView.heightAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleTextView.topAnchor.constraint(equalTo: starLabel.bottomAnchor).isActive = true
    }
    
    private func addBuyButton() {
        if viewModel.detail?.data.status == "ON_SALE" {
            mainScrollView.addSubview(buyImmediately)
            buyImmediately.centerXAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.centerXAnchor).isActive = true
            buyImmediately.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5).isActive = true
        } else {
            mainScrollView.addSubview(buyImmediately)
            mainScrollView.addSubview(buyDeal)
            buyImmediately.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5).isActive = true
            buyImmediately.leftAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
            
            buyDeal.topAnchor.constraint(equalTo: buyImmediately.topAnchor).isActive = true
            buyDeal.rightAnchor.constraint(equalTo: mainScrollView.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        }
    }
}
