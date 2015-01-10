//
//  AddTaskViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
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
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
