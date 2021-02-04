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
        self.setTimer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInitialize()
        self.setTimer()
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

    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            let nowX = self.contentOffset.x
            let nowY = self.contentOffset.y
            if nowX >= self.contentSize.width - UIScreen.main.bounds.width {
                // 처음부터 다시
                self.setContentOffset(CGPoint(x: 0, y: nowY), animated: false)
            } else {
                self.setContentOffset(CGPoint(x: nowX + UIScreen.main.bounds.width, y: nowY), animated: true)
            }
        }
    }

    private func addImageInScrollView(image: UIImage, indexOfImage: Int) {
        let imgView = UIImageView()
        imgView.image = image
        let positionX = UIScreen.main.bounds.width * CGFloat(indexOfImage)
        imgView.frame = CGRect(x: positionX, y: 0, width: self.frame.width, height: self.frame.height)
        imgView.contentMode = .scaleAspectFit

        self.contentSize.width = self.frame.width * CGFloat(indexOfImage + 1)
        self.addSubview(imgView)
    }

    private func setInitialize() {
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = true
    }
}
