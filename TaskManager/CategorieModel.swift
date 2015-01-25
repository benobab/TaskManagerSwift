//
//  CategorieModel.swift
//  TaskManager
//
//  Created by BenLacroix on 24/01/2015.
//  Copyright (c) 2015 Benobab. All rights reserved.
//

import Foundation
import CoreData

@objc(CategorieModel)
class CategorieModel: NSManagedObject {

    @NSManaged var taskArray: AnyObject //contient un tableau de TaskModel
    @NSManaged var categorieName: String
    @NSManaged var isActive: NSNumber //permet de savoir si elle est utilisé ou non et ensuite de la supprimer

}
