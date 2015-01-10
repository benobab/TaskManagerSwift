//
//  ViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    //STORYBOARD OUTLET
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultController:NSFetchedResultsController = NSFetchedResultsController()
    
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
         self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    //STORYBOARD FUNC
    @IBAction func addTaskButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("mainToAdd", sender: self)
    }
    
    
    @IBAction func trashCompletedButtonPressed(sender: UIButton) {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format:"completed == \(true)") //Ici on récupère tous les objets du core data dont completed = true
        
        var error : NSError?
        var items:[AnyObject]
        items = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!
        for item in items{
            managedObjectContext.deleteObject(item as NSManagedObject)
        }
        managedObjectContext.save(nil)
    }
    
    
    //DATASOURCE
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTask = fetchedResultController.objectAtIndexPath(indexPath) as TaskModel
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as TaskCell
        cell.titleLabel.text = thisTask.title
        cell.descriptionLabel.text = thisTask.descriptionTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        if(thisTask.completed == true)
        {
            cell.backgroundColor = UIColor(red: (253/255.0), green: (174/255.0), blue: (143/255.0), alpha: 1.0)
        }else
        {
            cell.backgroundColor = UIColor(red: (247/255.0), green: (251/255.0), blue: (145/255.0), alpha: 1.0)
        }
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultController.sections!.count
    }
    
    
    
    //DELEGATE

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("mainToDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format:"completed == \(true)") //Ici on récupère tous les objets du core data dont completed = true
        
        var error : NSError?
        var items:[AnyObject]
        items = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!
        if(items.count == 0){
            return "Complete Task"
        }
        else if(items.count > 0 && fetchedResultController.sections!.count == 1)
        {
            return "To Do"
        }
        else if(indexPath.section==0 )
        {
        return "Complete Task"
        }else
        {
        return "To Do"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "mainToAdd")
        {
            let addTaskViewController = segue.destinationViewController as AddTaskViewController
        }
        if(segue.identifier == "mainToDetail")
        {
            let detailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            detailViewController.detailTaskModel = fetchedResultController.objectAtIndexPath(indexPath!) as TaskModel
        }
    }
    
    
    //TABLEVIEW OPTION
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format:"completed == \(true)") //Ici on récupère tous les objets du core data dont completed = true
        
        var error : NSError?
        var items:[AnyObject]
        items = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!
        
        
        if section == 0 {
            if( fetchedResultController.sections!.count == 1 && items.count > 0)
            {
            return "Completed"
            }
            return "To do"
        }
        else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = fetchedResultController.objectAtIndexPath(indexPath) as TaskModel
        
        if (thisTask.completed == false) {
            thisTask.completed = true
        }
        else {
            thisTask.completed = false
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    
    
    //FONCTIONS UTILES
    
    func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
        return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
    }
    
    func taskFetchRequest()-> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchedResultController() -> NSFetchedResultsController{
         fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchedResultController
    }
    

    
    
    //FETCHED DELEGATE
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}

