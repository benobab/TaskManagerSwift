//
//  TaskModel.swift
//  TaskManager
//
//  Created by BenLacroix on 10/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import Foundation
import CoreData
@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var descriptionTask: String
    @NSManaged var date: NSDate
    @NSManaged var completed: NSNumber

}
