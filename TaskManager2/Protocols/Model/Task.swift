//
//  Task.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


protocol Task {
    
    func getType() -> TaskType
    func getStatus() -> TaskStatus
    func getName() -> String
    
    func setStatus(_ newStatus: TaskStatus)
}

enum TaskStatus: String {
    case waiting
    case completed
    case denied
}
