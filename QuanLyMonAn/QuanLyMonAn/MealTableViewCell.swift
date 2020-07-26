//
//  MealTableViewCell.swift
//  QuanLyMonAn
//
//  Created by Khiem Tran on 7/5/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mealImages: UIImageView!
    
    @IBOutlet weak var mealRatingControl: RatingControl!
    @IBOutlet weak var mealNames: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
