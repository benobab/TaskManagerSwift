//
//  TaskDetailViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit
import CoreData
class TaskDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var detailTaskModel: TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = detailTaskModel.title
        descriptionTextField.text = detailTaskModel.descriptionTask
        datePicker.date = detailTaskModel.date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        detailTaskModel.title = titleTextField.text
        detailTaskModel.descriptionTask = descriptionTextField.text
        detailTaskModel.date = datePicker.date
        detailTaskModel.date = datePicker.date
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
