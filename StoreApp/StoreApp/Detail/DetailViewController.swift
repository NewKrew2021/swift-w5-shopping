//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/04.
//

import UIKit
import WebKit

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
        addInfoView()
        addWebView()
        scrollView.addImages(urls: viewModel.detail?.data.previewUrls ?? [])
    }

    // MARK: Private

    private var scrollView = DetailScrollView()
    private var contentView = UIView()
    private var mainScrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        view.contentSize = CGSize(width: 1000, height: 1000)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isDirectionalLockEnabled = true
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
        let button = EllipseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("바로구매 00원", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.tintColor = .black
        return button
    }()
    
    private var buyDeal: EllipseButton = {
        let button = EllipseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("톡딜가 00원", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .yellow
        button.tintColor = .yellow
        return button
    }()
    
    private var infoView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollView.isScrollEnabled = false
        return view
    }()

    private func addMainScrollView() {
        view.addSubview(mainScrollView)
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        mainScrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor).isActive = true
        contentView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height*3)
    }
    
    private func addDetailScrollView() {
        contentView.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func addReviewView() {
        contentView.addSubview(starLabel)
        contentView.addSubview(reviewLabel)
        
        reviewLabel.topAnchor.constraint(equalTo: starLabel.topAnchor).isActive = true
        reviewLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor, constant: 30).isActive = true
        reviewLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        starLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
        starLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor, constant: -30).isActive = true
        starLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addTitleView() {
        contentView.addSubview(titleTextView)
        titleTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        titleTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleTextView.topAnchor.constraint(equalTo: starLabel.bottomAnchor).isActive = true
    }
    
    private func addBuyButton() {
        if viewModel.detail?.data.status != "ON_SALE" {
            contentView.addSubview(buyImmediately)
            buyImmediately.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            buyImmediately.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.33).isActive = true
            buyImmediately.heightAnchor.constraint(equalToConstant: 50).isActive = true
            buyImmediately.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5).isActive = true
            buyImmediately.makeEllipse()
        } else {
            contentView.addSubview(buyImmediately)
            contentView.addSubview(buyDeal)
            
            buyImmediately.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5).isActive = true
            buyImmediately.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
            buyImmediately.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
            buyImmediately.heightAnchor.constraint(equalToConstant: 50).isActive = true
            buyImmediately.makeEllipse()
            
            buyDeal.topAnchor.constraint(equalTo: buyImmediately.topAnchor).isActive = true
            buyDeal.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
            buyDeal.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
            buyDeal.heightAnchor.constraint(equalToConstant: 50).isActive = true
            buyDeal.makeEllipse()
        }
    }
    
    private func addInfoView() {
        contentView.addSubview(infoView)
        infoView.topAnchor.constraint(equalTo: buyImmediately.bottomAnchor, constant: 5).isActive = true
        infoView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor).isActive = true
        infoView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func addWebView() {
        contentView.addSubview(webView)
        webView.loadHTMLString(viewModel.detail?.data.description ?? "", baseURL: nil)
        webView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 5).isActive = true
        webView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        contentView.sizeToFit()
    }
}
