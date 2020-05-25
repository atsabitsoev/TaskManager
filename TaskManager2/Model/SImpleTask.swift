//
//  SImpleTask.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import CoreData


class SimpleTask: Task, CoreDataUsable {
    
    
    init(name: String, status: TaskStatus = .waiting) {
        self.name = name
        self.status = status
    }
    
    
    private var name: String
    private var status: TaskStatus
    private var coreDataId: NSManagedObjectID?
    
    
    
    func getName() -> String {
        return name
    }
    
    func getType() -> TaskType {
        return .simpleTask
    }
    
    func getStatus() -> TaskStatus {
        return status
    }
    
    func getCoreDataId() -> NSManagedObjectID? {
        return coreDataId
    }
    
    func setCoreDataId(_ id: NSManagedObjectID?) {
        self.coreDataId = id
    }
    
    
    func setStatus(_ newStatus: TaskStatus) {
        self.status = newStatus
    }
        
}
