//
//  TableItemsViewModel.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


protocol TableTasksViewModelProtocol {
    
    func getState() -> TableTasksViewState
    
    func numberOfRows(inSection section: Int) -> Int
    func cellViewModel(forSection section: Int, row: Int) -> TaskCellViewModel
    func setTableState(_ newState: TableTasksViewState)
    
    func fetchTasks()
    func changeStatusOfTask(inSection section: Int, row: Int, to newStatus: TaskStatus)
    func saveNewTask(withName name: String)
    func removeTask(inSection section: Int, row: Int)
}


enum TableTasksViewState {
    case waitingTasks
    case completedTasks
    case deniedTasks
}
