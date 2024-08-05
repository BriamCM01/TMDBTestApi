//
//  String+Extension.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
