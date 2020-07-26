//
//  MealTableViewController.swift
//  QuanLyMonAn
//
//  Created by Khiem Tran on 7/5/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //MARK: properties
    private var mealList = [Meal]()

    //mark the direction of navigation
    enum NavigationDirection{
        case addNewMeal
        case updateMeal
    }
    
    var navigationDirection: NavigationDirection = .addNewMeal
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load the mealList
        loadMeal()
        //add the edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mealList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
//            print("can not read the cell!")
            fatalError("can not read the cell!")
        }
        let meal = mealList[indexPath.row]
        cell.mealNames.text = meal.name
        cell.mealImages.image = meal.image
        cell.mealRatingControl.rating = meal.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mealList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier ?? ""
        guard let destinantionController = segue.destination as? MealDetailController else {
            print("can not get the destination Controller")
            return
        }
        switch identifier {
        case "addMeal":
            print("Add a New Meal!")
            navigationDirection = .addNewMeal
            destinantionController.navigationDirection = .addNewMeal
        case "updateMeal":
            print("Update a Meal")
            navigationDirection = .updateMeal
            destinantionController.navigationDirection = .updateMeal
            guard let selectedCell = sender as? MealTableViewCell else{
                print("Can not get the selected cell")
                return
            }
            //get the position of selected Cell int the mealList
            guard let indexPath = tableView.indexPath(for: selectedCell) else{
                print("can not get the position of the selected Cell!")
                return
            }
            //get the destination of segue
            
            //get the meal of selected cell
            destinantionController.meal = mealList[indexPath.row]
        default:
            print("You Are Not Name The Segue!")
            return
        }
    }
    

    func loadMeal(){
        if let meal = Meal(name: "Banh Beo", image: UIImage(named: "DefaultImage"), rating: 4){
            mealList += [meal]
        }
    }
    
    //MARK: unWind for segue
    @IBAction func unWidFromDetailMealController(sender: UIStoryboardSegue){
        //get the new meal from MealDetailController
        switch navigationDirection {
        case .addNewMeal:
             if let sourceController = sender.source as? MealDetailController, let newMeal = sourceController.meal {
                      //calculate new position in the table
                       let newIndexPath = IndexPath(row: mealList.count, section: 0)
                       //add the new meal into the mealList
                       mealList.append(newMeal)
                       //insert the newMeal into the tableView
                       tableView.insertRows(at: [newIndexPath], with: .automatic)
                 }
        case .updateMeal:
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                if let sourceController = sender.source as? MealDetailController, let updateMeal = sourceController.meal {
                    //update to the meal list
                    mealList[selectedIndexPath.row] = updateMeal
                    //update to table view
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            }
        default:
            print("Unknown the direction!")
            break
       
       
        }
    }
}
