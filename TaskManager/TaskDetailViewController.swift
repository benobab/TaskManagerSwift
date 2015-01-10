//
//  TaskDetailViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var mainVC: ViewController!
    var detailTaskModel: TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = detailTaskModel.title
        descriptionTextField.text = detailTaskModel.description
        datePicker.date = detailTaskModel.date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        var task = TaskModel(title: titleTextField.text, description: descriptionTextField.text, date: datePicker.date)
        mainVC.taskArray[self.mainVC.tableView.indexPathForSelectedRow()!.row] = task
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
