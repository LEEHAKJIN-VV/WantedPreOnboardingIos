//
//  Ex+UIImageView.swift
//  WantedPreOnboarding
//
//  Created by 이학진 on 2023/03/01.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard
                let imageData = try? Data(contentsOf: url),
                let loadedImage = UIImage(data: imageData)
            else { return }
            DispatchQueue.main.async {
                self?.image = loadedImage
            }
        }
    }
}
