//
//  ViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //STORYBOARD OUTLET
    @IBOutlet weak var tableView: UITableView!
    
     var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: "01/14/2014")
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: "01/14/2014")
        taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: "01/14/2014")]
        
         self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //DATASOURCE
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTask = taskArray[indexPath.row]
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as TaskCell
        cell.titleLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = thisTask.date
        return cell
        
    }
    
    
    
    //DELEGATE

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

