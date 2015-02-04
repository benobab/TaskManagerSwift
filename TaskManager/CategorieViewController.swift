//
//  CategorieViewController.swift
//  TaskManager
//
//  Created by BenLacroix on 24/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import UIKit
import CoreData

class CategorieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        self.tableView.reloadData()
    }
    
    
    @IBAction func addCategorieButtonPressed(sender: UIBarButtonItem) {
        var alert = UIAlertController(title: "Add Category", message: "Choose a categorie name", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add a categorie Name "
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
            textField.secureTextEntry = false //don't know why
        }
        let texftField = alert.textFields![0] as UITextField
        
        let addCategorieName = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            if(texftField.text.isEmpty == false)
            {
                self.addCategorieToCoreData(texftField.text)
            }
        }
        alert.addAction(addCategorieName)
        
        let cancelButon = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (cancelAction) -> Void in
            
        }
        alert.addAction(cancelButon)
        self.presentViewController(alert,animated: true, completion: nil)
        
    }
    
    func addCategorieToCoreData(categorieName: String){
    //Enregistrer la categorie dans le CoreData et reload la tableView
        let entityDescription = NSEntityDescription.entityForName("CategorieModel", inManagedObjectContext: managedObjectContext)
        let categorie = CategorieModel(entity: entityDescription!,insertIntoManagedObjectContext : managedObjectContext)
        categorie.categorieName = categorieName
        categorie.isActive = true
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        var request = NSFetchRequest(entityName: "CategorieModel")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext.executeFetchRequest(request, error: &error)!
        self.fetchedResultController.performFetch(&error)
        
        self.tableView.reloadData()

}

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var renameAction = UITableViewRowAction(style: .Normal, title: "Rename") { (action, indexPath) -> Void in
            tableView.editing = false
            self.renameCategorie(indexPath)
        }
        renameAction.backgroundColor = UIColor.grayColor()
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) -> Void in
            tableView.editing = false
            self.deletedCategorie(indexPath)
        }
        deleteAction.backgroundColor = UIColor.redColor()
            return [deleteAction,renameAction]
        }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisCategorie = fetchedResultController.objectAtIndexPath(indexPath) as CategorieModel
        let result = self.getNombreTaskForCategorie(thisCategorie.categorieName)
        var cell:CategorieCell = tableView.dequeueReusableCellWithIdentifier("CategorieCell") as CategorieCell
        cell.categorieLabel.text = thisCategorie.categorieName
        cell.nombreLabel.text = "(\(result))"
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let thisCategorie = fetchedResultController.objectAtIndexPath(indexPath) as CategorieModel
        performSegueWithIdentifier("showTaskCategorie", sender: thisCategorie.categorieName)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
//        Don't need for now
        
    }
    
    
    
    //une seule section pour le moment ensuite on pourra supprimer des catégories
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultController.sections!.count
    }
    
    func categorieFetchRequest()-> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "CategorieModel")
        NSFetchedResultsController.deleteCacheWithName(nil)
        let completedDescriptor = NSSortDescriptor(key: "isActive", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor]
        
        return fetchRequest
    }
    func getFetchedResultController() -> NSFetchedResultsController{
        fetchedResultController = NSFetchedResultsController(fetchRequest: categorieFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "isActive", cacheName: nil)
        return fetchedResultController
    }
    
    
    func getNombreTaskForCategorie(categorie: String) -> Int{
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format: "categorie = %@ AND completed == \(false)",categorie)
        var error : NSError?
        var items:[AnyObject]
        items = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!

        return items.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showTaskCategorie")
        {
            let taskVC = segue.destinationViewController as ViewController
            taskVC.current_Category = sender as String
            taskVC.title = sender as? String
        }
    }
    
    
    
    func deletedCategorie(indexPath:NSIndexPath) {
        let thisCategorie = fetchedResultController.objectAtIndexPath(indexPath) as CategorieModel
        

        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format:"categorie = %@",thisCategorie.categorieName) //Ici on récupère tous les objets du core data dont completed = true
        
        var error : NSError?
        var items:[AnyObject]
        items = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!
        for item in items{
            managedObjectContext.deleteObject(item as NSManagedObject)
        }
        //après avoir supprimé les tâches de cette catégorie, on supprime la catégorie elle même
        managedObjectContext.deleteObject(thisCategorie as NSManagedObject)
        
        managedObjectContext.save(nil)
        self.fetchedResultController.performFetch(&error)
        self.tableView.reloadData()
    }
    
    func renameCategorie(indexPath:NSIndexPath)
    {
        let thisCategorie = self.fetchedResultController.objectAtIndexPath(indexPath) as CategorieModel
        //ici renomer catégorie ET toutes les tâches de cette catégorie
        var alert = UIAlertController(title: "Rename Category", message: "Choose a categorie name", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = thisCategorie.categorieName
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
            textField.secureTextEntry = false //don't know why
        }
        let texftField = alert.textFields![0] as UITextField
        
        let renameCategorieName = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            if(texftField.text.isEmpty == false)
            {
                let fetchRequest = NSFetchRequest(entityName: "TaskModel")
                fetchRequest.predicate = NSPredicate(format:"categorie = %@",thisCategorie.categorieName) //Ici on récupère tous les objets de la catégorie courrante
                var error : NSError?
                var items:[AnyObject]
                items = self.managedObjectContext.executeFetchRequest(fetchRequest, error: &error)!
                for item in items{
                    let task = item as TaskModel
                    task.categorie = texftField.text
                }
                thisCategorie.categorieName = texftField.text
                self.managedObjectContext.save(nil)
                self.tableView.reloadData()
            }
        }
        alert.addAction(renameCategorieName)
        
        let cancelButon = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (cancelAction) -> Void in
            
        }
        alert.addAction(cancelButon)
        
        self.presentViewController(alert,animated: true, completion: nil)
        
        
        
    }

}
