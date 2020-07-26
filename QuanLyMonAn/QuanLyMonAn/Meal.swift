//
//  Meal.swift
//  QuanLyMonAn
//
//  Created by Khiem Tran on 6/28/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import Foundation
import UIKit
class Meal {
    var name:String
    var image:UIImage?
    var rating:Int
    
    init?(name: String, image: UIImage?, rating: Int) {
        guard !name.isEmpty else {
            return nil
        }
        guard rating >= 0 && rating <= 5 else {
            return nil
        }
        
        self.name = name
        self.image = image
        self.rating = rating
    }
}
