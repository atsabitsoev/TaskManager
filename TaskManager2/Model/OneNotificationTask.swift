//
//  OneNotificationTask.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 25.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


final class OneNotificationTask: SimpleTask {
    
    
    private var notificationProvider: NotificationProvider!
    
    
    init(name: String,
         status: TaskStatus = .waiting,
         notificationDate: Date) {
        self.notificationDate = notificationDate
        super.init(name: name, status: status)
    }
    
    
    override func getType() -> TaskType {
        return .oneNotificationTask
    }
    
    private var notificationDate: Date
    
    
    func getNotificationDate() -> Date {
        return notificationDate
    }
}
