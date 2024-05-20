//
//  UIImage+data.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import UIKit

extension UIImage {
    func dataConvert(data: Data?) -> UIImage {
        guard let data, let uiImage = UIImage(data: data) else {
            return UIImage(systemName: "photo")!
        }
        return uiImage
    }
}
