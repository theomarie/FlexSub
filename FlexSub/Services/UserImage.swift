//
//  UserImage.swift
//  FlexSub
//
//  Created by Theo Marie on 30/10/2024.
//

import Foundation
import SwiftUI

struct UserImage {
    let image: UIImage?
    let url: String?
    
    static let defaultImage = UIImage(systemName: "person.circle.fill")
    static let defaultUrl: String = "https://via.placeholder.com/100x100"
    
    init(image: UIImage? = nil, url: String? = nil) {
        self.image = image ?? UserImage.defaultImage
        self.url = url ?? UserImage.defaultUrl
    }
}
