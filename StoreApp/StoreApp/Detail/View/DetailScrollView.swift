//
//  DetailScrollView.swift
//  StoreApp
//
//  Created by 지현우 on 2021/02/04.
//

import UIKit

class DetailScrollView: UIScrollView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInitialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInitialize()
    }

    // MARK: Internal

    func addImages(urls: [String]) {
        var cnt = 0
        urls.forEach { str in
            guard let url = URL(string: str) else { return }
            Request.shared.loadImage(url: url) { image, _ in
                guard let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.addImageInScrollView(image: image, indexOfImage: cnt)
                    cnt += 1
                }
            }
        }
    }

    // MARK: Private

    private func addImageInScrollView(image: UIImage, indexOfImage: Int) {
        let imgView = UIImageView()
        imgView.image = image
        let positionX = UIScreen.main.bounds.width * CGFloat(indexOfImage)
        imgView.frame = CGRect(x: positionX, y: 0, width: self.frame.width, height: self.frame.height)
        imgView.contentMode = .scaleAspectFit
        print(imgView.frame)

        self.contentSize.width = self.frame.width * CGFloat(indexOfImage + 1)
        self.addSubview(imgView)
    }

    private func setInitialize() {
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = true
    }
}
