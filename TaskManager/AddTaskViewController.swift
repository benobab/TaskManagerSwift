//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit
import CoreData
class AddTaskViewController: UIViewController {

    
    //STORYBOARD OUTLET
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var current_Category:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ACTION STORYBOARD
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func addTaskButtonPressed(sender: UIBarButtonItem) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!,insertIntoManagedObjectContext : managedObjectContext!)
        task.title = titleTextField.text
        task.descriptionTask = descriptionTextField.text
        task.date = datePicker.date
        task.completed = false
        task.categorie = current_Category
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        navigationController?.popViewControllerAnimated(true)
    }
}
