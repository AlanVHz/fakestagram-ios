//
//  UImage+Base64.swift
//  fakestagram
//
//  Created by Alan Vargas on 27.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func encodedBase64() -> String? {
        guard let data = self.jpegData(compressionQuality: 0.95) else { return nil }
        return "data:image/jpeg;base64,\(data.base64EncodedString())"
    }
}
