//
//  CoreDataService.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import CoreData


final class CoreDataService: CoreDataTaskProvider {
    
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    
    func fetchTasks() -> [Task] {
        
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let taskEntities = try context.fetch(request)
            let tasks = taskEntities.compactMap { (taskEntity) -> Task? in
                return taskEntity.toTask()
            }
            
            return tasks
        } catch {
            print(error)
            return []
        }
    }
    
    func saveTask( _ task: Task) -> NSManagedObjectID {
        
        switch task.getType() {
        case .simpleTask:
            let entityDescription = NSEntityDescription.entity(forEntityName: "SimpleTaskEntity", in: context)!
            let newTaskEntity = NSManagedObject(entity: entityDescription, insertInto: context) as! SimpleTaskEntity
            let simpleTask = task as! SimpleTask
            
            newTaskEntity.name = simpleTask.getName()
            newTaskEntity.type = simpleTask.getType().rawValue
            newTaskEntity.status = simpleTask.getStatus().rawValue
            
            saveContext()
            
            return newTaskEntity.objectID
        case .oneNotificationTask:
            let entityDescription = NSEntityDescription.entity(forEntityName: "OneNotificationTaskEntity", in: context)!
            let newTaskEntity = NSManagedObject(entity: entityDescription, insertInto: context) as! OneNotificationTaskEntity
            let oneNotificationTask = task as! OneNotificationTask
            
            newTaskEntity.name = oneNotificationTask.getName()
            newTaskEntity.type = oneNotificationTask.getType().rawValue
            newTaskEntity.status = oneNotificationTask.getStatus().rawValue
            newTaskEntity.notificationDate = oneNotificationTask.getNotificationDate()
            
            saveContext()
            
            return newTaskEntity.objectID
        }
        
    }
    
    func changeTaskStatus(coreDataId: NSManagedObjectID, newStatus: TaskStatus) {
        
        do {
            let taskEntity = try context.existingObject(with: coreDataId) as! TaskEntity
            taskEntity.status = newStatus.rawValue
            saveContext()
        } catch {
            print(error)
        }
    }
    
    func removeTask(coreDataId: NSManagedObjectID) {
        let taskEntityToDelete = context.object(with: coreDataId)
        context.delete(taskEntityToDelete)
        saveContext()
    }
    
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
}
