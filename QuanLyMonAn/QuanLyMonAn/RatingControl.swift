//
//  RatingControl.swift
//  QuanLyMonAn
//
//  Created by Khiem Tran on 6/21/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //Mark: properties
    @IBInspectable var rating:Int = 0 {
        didSet{
            updateButtonState()
        }
    }
    private var buttons = [UIButton]()
    
    @IBInspectable var butonSize: CGSize = CGSize(width: 44.0, height: 44.0)
    {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var buttonCount: Int = 5
    {
        didSet {
            setupButtons()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder	)
        setupButtons()
    }
    
    //MARKS: initiation of rating buttons
    func setupButtons(){
        //remove all button
        for button in buttons{
            //remove in stackView
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        buttons.removeAll()
        
        //load images for button
                  let bundle = Bundle(for: type(of: self))
                  let imageNormal = UIImage(named: "normal", in: bundle, compatibleWith: self.traitCollection)
                  let imageHighLight = UIImage(named: "highlight", in: bundle, compatibleWith: self.traitCollection)
                  let imageSelected = UIImage(named: "selected", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<buttonCount {
            //Create a new button
                   let button = UIButton()
                  // button.backgroundColor = UIColor.green
          
            
            //set images and static foreach
            button.setImage(imageNormal, for: .normal)
            button.setImage(imageSelected, for: .selected)
            button.setImage(imageHighLight, for: .highlighted)
            
                   button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: butonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: butonSize.width).isActive = true
                   //processing event for the button
                   button.addTarget(self, action: #selector(buttonProcessing(button:)), for: .touchUpInside)
                   
                   //Add the buttons to StackView
                   addArrangedSubview(button)
            
            //add to the button array
            buttons.append(button)
        }
        updateButtonState()	
    }
    
    @objc private func buttonProcessing(button: UIButton){
        //print("The Button is pressed")
        guard let buttonIndex = buttons.firstIndex(of: button) else{
            fatalError("Can not get the button index!")
        }
        //caculator the rating of rating control
        let selectedRating = buttonIndex + 1
        if selectedRating == rating {
            rating -= 1
        }
        else{
            rating = selectedRating
        }
        updateButtonState()
    }
    
    private func updateButtonState(){
        //enumerated tra ve 1 (bo)
        for (index, item) in buttons.enumerated() {
            item.isSelected = index < rating
        }
    }
    
}
