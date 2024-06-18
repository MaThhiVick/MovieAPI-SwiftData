//
//  File.swift
//  
//
//  Created by Matheus Vicente on 17/06/24.
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
