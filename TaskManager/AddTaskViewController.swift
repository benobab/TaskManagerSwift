//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    
    //STORYBOARD OUTLET
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //Pour communiquer avec les autres VC
    var mainVC:ViewController!
    
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
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func addTaskButtonPressed(sender: UIBarButtonItem) {
        var task = TaskModel(title: titleTextField.text, description: descriptionTextField.text, date: datePicker.date)
        mainVC.taskArray.append(task)
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
