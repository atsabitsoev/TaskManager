//
//  SimpleTaskCellViewModel.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


final class SimpleTaskCellViewModel: TaskCellViewModel {
    
    
    init(task: Task) {
        self.task = task
    }
    
    
    private var task: Task!
    
    
    func getTaskName() -> String {
        return task.getName()
    }
    
    func getTaskType() -> TaskType {
        return task.getType()
    }
    
}
