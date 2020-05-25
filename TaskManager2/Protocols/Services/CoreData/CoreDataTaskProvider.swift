//
//  CoreDataTaskProvider.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 24.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import CoreData


protocol CoreDataTaskProvider: TaskProvider {
    
    func changeTaskStatus(coreDataId: NSManagedObjectID, newStatus: TaskStatus)
    func saveTask( _ task: Task) -> NSManagedObjectID
    func removeTask(coreDataId: NSManagedObjectID)
}
