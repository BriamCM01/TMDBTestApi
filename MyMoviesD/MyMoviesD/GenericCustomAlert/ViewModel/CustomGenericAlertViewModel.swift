//
//  CustomGenericAlertViewModel.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import Foundation

class CustomGenericAlertViewModel {
    var title: String
    var img: String
    var overview: String
    
    init(title: String, img: String, overview: String) {
        self.title = title
        self.img = img
        self.overview = overview
    }
}
