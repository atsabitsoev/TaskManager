//
//  TableTasksViewModel.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


final class TableTasksViewModel: TableTasksViewModelProtocol {
    
    
    private let taskProvider: CoreDataTaskProvider = CoreDataService()
    private var state: TableTasksViewState = .waitingTasks
        
    
    private var allTasks: [Task] = [] {
        didSet {
            waitingTasks = allTasks.filter({ $0.getStatus() == .waiting })
            completedTasks = allTasks.filter({ $0.getStatus() == .completed })
            deniedTasks = allTasks.filter({ $0.getStatus() == .denied })
        }
    }
    private var waitingTasks: [Task] = []
    private var completedTasks: [Task] = []
    private var deniedTasks: [Task] = []
    
    private var currentTasks: [Task] {
        get {
            switch state {
            case .waitingTasks: return waitingTasks
            case .completedTasks: return completedTasks
            case .deniedTasks: return deniedTasks
            }
        }
    }
    
    
    func getState() -> TableTasksViewState {
        return state
    }
    
    
    func numberOfRows(inSection section: Int) -> Int {
        return currentTasks.count
    }
    
    func cellViewModel(forSection section: Int, row: Int) -> TaskCellViewModel {
        let currentTask = currentTasks[row]
        switch currentTask.getType() {
        case .simpleTask: return SimpleTaskCellViewModel(task: currentTask)
        case .oneNotificationTask: return SimpleTaskCellViewModel(task: currentTask)
        }
    }
    
    func setTableState(_ newState: TableTasksViewState) {
        self.state = newState
    }
    
    
    func fetchTasks() {
        allTasks = taskProvider.fetchTasks()
    }
    
    func changeStatusOfTask(inSection section: Int, row: Int, to newStatus: TaskStatus) {
        guard let taskToChange = currentTasks[row] as? CoreDataUsable,
            let coreDataId = taskToChange.getCoreDataId() else { return }
        
        taskProvider.changeTaskStatus(coreDataId: coreDataId, newStatus: newStatus)
        fetchTasks()
    }
    
    func saveNewTask(withName name: String) {
        let newTask = SimpleTask(name: name)
        _ = taskProvider.saveTask(newTask)
        fetchTasks()
    }
    
    func removeTask(inSection section: Int, row: Int) {
        guard let taskToDelete = currentTasks[row] as? CoreDataUsable,
            let coreDataId = taskToDelete.getCoreDataId() else { return }
        taskProvider.removeTask(coreDataId: coreDataId)
        fetchTasks()
    }
    
    
    
}
