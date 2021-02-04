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
        addScrollView()
        addReviewView()
        addTitleView()
        scrollView.addImages(urls: viewModel.detail?.data.previewUrls ?? [])
    }

    // MARK: Private

    private var scrollView = DetailScrollView()
    
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

    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func addReviewView() {
        view.addSubview(starLabel)
        view.addSubview(reviewLabel)
        starLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
        reviewLabel.topAnchor.constraint(equalTo: starLabel.topAnchor).isActive = true
        starLabel.trailingAnchor.constraint(equalTo: reviewLabel.leadingAnchor, constant: -20).isActive = true
        reviewLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 30).isActive = true
    }
    
    private func addTitleView(){
        view.addSubview(titleTextView)
        titleTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        titleTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleTextView.topAnchor.constraint(equalTo: starLabel.bottomAnchor).isActive = true
    }
}
