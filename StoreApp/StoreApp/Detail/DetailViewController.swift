//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/04.
//

import UIKit

class DetailViewController: UIViewController {
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addScrollView()
        scrollView.addImages(urls: viewModel.detail?.data.previewUrls ?? [])
    }
    
    private var scrollView = DetailScrollView()
    
    private func addScrollView(){
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
    }
    
}
