//
//  TaskEntityExtension.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import CoreData


extension TaskEntity {
    
    func toTask() -> Task? {
        
        guard let taskType = TaskType(rawValue: self.type!) else { return nil }
        guard let name = self.name else { return nil }
        guard let statusString = self.status, let status = TaskStatus(rawValue: statusString) else { return nil }
        
        switch taskType {
        case .simpleTask:
            let simpleTask = SimpleTask(name: name, status: status)
            simpleTask.setCoreDataId(self.objectID)
            return simpleTask
        case .oneNotificationTask:
            guard let thisOneNotifTask = self as? OneNotificationTaskEntity
                , let notifDate = thisOneNotifTask.notificationDate else { return nil }
            let oneNotificationTask = OneNotificationTask(name: name, status: status, notificationDate: notifDate)
            return oneNotificationTask
        }
    }
    
}
