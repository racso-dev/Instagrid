//
//  Converter.swift
//  Instagrid
//
//  Created by Oscar RENIER on 23/09/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Converter class used to convert a UIView to a UIImage
class Converter {


    // MARK: - Method that transform a UIView into a UIImage
    func viewToUIImage(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
