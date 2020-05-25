//
//  TaskProvider.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


protocol TaskProvider {
    
    func fetchTasks() -> [Task]
}
