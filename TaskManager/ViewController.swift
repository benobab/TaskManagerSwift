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
        let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2014, month: 03, day: 3)
        let date3 = Date.from(year: 2014, month: 12, day: 13)
        
        let task1 = TaskModel(title: "Study French", description: "Verbs", date: date1)
        let task2 = TaskModel(title: "Eat Dinner", description: "Burgers", date: date2)
        
        taskArray = [task1, task2, TaskModel(title: "Gym", description: "Leg Day", date: date3)]
        
         self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.taskArray = taskArray.sorted(sortByDate)
        self.tableView.reloadData()
    }
    
    //STORYBOARD FUNC
    @IBAction func addTaskButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("mainToAdd", sender: self)
    }
    
    
    
    
    //DATASOURCE
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTask = taskArray[indexPath.row]
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as TaskCell
        cell.titleLabel.text = thisTask.title
        cell.descriptionLabel.text = thisTask.description
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        return cell
        
    }
    
    
    
    //DELEGATE

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var task:TaskModel = taskArray[indexPath.row]
        performSegueWithIdentifier("mainToDetail", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "mainToAdd")
        {
            let addTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskViewController.mainVC = self
        }
        if(segue.identifier == "mainToDetail")
        {
            let detailViewController = segue.destinationViewController as TaskDetailViewController
            detailViewController.detailTaskModel = taskArray[self.tableView.indexPathForSelectedRow()!.row]
            detailViewController.mainVC = self
        }
    }
    
    
    
    
    //FONCTIONS UTILES
    
    func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
        return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
    }

}

