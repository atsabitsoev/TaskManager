//
//  NewTaskViewItem.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 25.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


final class NewTaskViewItem {
    
    
    init(name: String, notificationDate: Date? = nil) {
        self.name = name
        self.notificationDate = notificationDate
    }
    
    
    private var name: String
    private var notificationDate: Date?
    
    
    func getName() -> String {
        return name
    }
    
    func getNotificationDate() -> Date? {
        return notificationDate
    }
}
