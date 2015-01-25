//
//  TaskModel.swift
//  TaskManager
//
//  Created by BenLacroix on 24/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import Foundation
import CoreData
@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var descriptionTask: String
    @NSManaged var title: String
    @NSManaged var categorie: String

}
