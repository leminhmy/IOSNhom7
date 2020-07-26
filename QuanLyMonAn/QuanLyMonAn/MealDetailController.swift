//
//  ViewController.swift
//  QuanLyMonAn
//
//  Created by CNTT on 6/15/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import UIKit

class MealDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: properties
    var meal: Meal?
    
    enum NavigationDirection{
        case addNewMeal
        case updateMeal
    }
    
    var navigationDirection: NavigationDirection = .addNewMeal
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var edtMealName: UITextField!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealRatingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Uy quyen
        edtMealName.delegate = self
        
        if let theMeal = meal{
            navigationItem.title = theMeal.name
            edtMealName.text = theMeal.name
            mealImage.image = theMeal.image
            mealRatingControl.rating = theMeal.rating
        }
        
        updateSaveButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        edtMealName.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //lblMealName.text = edtMealName.text
        navigationItem.title = edtMealName.text
        updateSaveButton()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    //MARK: actions
    @IBAction func goToMap(_ sender: Any) {
        //lblMealName.text = edtMealName.text
    }
    @IBAction func tapOnPictureAction(_ sender: Any) {
        //print("the picture is tapped")
        edtMealName.resignFirstResponder()
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Mark:
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else{
                fatalError("Can not get the Image")
        }
        mealImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //Mark: for navigation controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pressedButton = sender as? UIBarButtonItem, pressedButton === saveButton else {
            print("This is not the save button!")
            return
        }
        //Preparing for the save button
        let mealName = edtMealName.text ?? 	""
        meal = Meal(name: mealName, image: mealImage.image, rating: mealRatingControl.rating)
    }
    
    //Mark: update save button
    func updateSaveButton(){
        let mealName = edtMealName.text ?? ""
        saveButton.isEnabled = !mealName.isEmpty
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        switch navigationDirection {
        case .addNewMeal:
            dismiss(animated: true, completion: nil)
        case .updateMeal:
            if let theNavigationController = navigationController{
                theNavigationController.popViewController(animated: true)
            }
      
        }
        
    }
}

