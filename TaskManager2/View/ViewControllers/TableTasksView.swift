//
//  TableTasksView.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import SnapKit


final class TableTasksView: UIViewController, TableItemsView {
    
    
    private var viewModel: TableTasksViewModelProtocol!
    
    
    private var segmentedControl: UISegmentedControl!
    private let tableView = UITableView()
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TableTasksViewModel()
        
        view.setNeedsUpdateConstraints()
        
        setupNavigationBar()
        setupNavigationItems()
        setupView()
        setupTableView()
        
        viewModel.fetchTasks()
        tableView.reloadData()
    }
    
    override func updateViewConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        super.updateViewConstraints()
    }
    
    
    //MARK: SETUP
    private func setupNavigationBar() {
        let imageWaiting = NavigationBarSegment.waiting.image().withRenderingMode(.alwaysOriginal)
        let imageCompleted = NavigationBarSegment.completed.image().withRenderingMode(.alwaysOriginal)
        let imageDenied = NavigationBarSegment.denied.image().withRenderingMode(.alwaysOriginal)
        
        segmentedControl = UISegmentedControl(items: [imageWaiting, imageCompleted, imageDenied])
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        navigationItem.titleView = segmentedControl
    }
    
    private func setupNavigationItems() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        self.navigationItem.setRightBarButton(addItem, animated: false)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK: Navigation
    private func showNewTaskView() {
        let vc = NewTaskView()
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        }
        let navigation = MainNavigationController(rootViewController: vc)
        vc.delegate = self
        self.present(navigation, animated: true, completion: nil)
    }
    
    
    //MARK: User Actions
    @objc private func segmentChanged() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        guard let selectedSegment = NavigationBarSegment(rawValue: selectedIndex) else { return }
        var newState: TableTasksViewState
        switch selectedSegment {
        case .waiting: newState = .waitingTasks
        case .completed: newState = .completedTasks
        case .denied: newState = .deniedTasks
        }
        viewModel.setTableState(newState)
        tableView.reloadData()
    }
    
    @objc private func addItemTapped() {
        showNewTaskView()
    }
    
}


//MARK: TableView
extension TableTasksView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(forSection: indexPath.section, row: indexPath.row)
        var cell: TaskCell!
        switch cellViewModel.getTaskType() {
        case .simpleTask: cell = SimpleTaskCell(viewModel: cellViewModel)
        case .oneNotificationTask: cell = SimpleTaskCell(viewModel: cellViewModel)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    //Right Swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        switch viewModel.getState() {
        case .waitingTasks:
            
            let denieAction = UIContextualAction(style: .destructive, title: "Не выполнено") { (_, _, _) in
                self.viewModel.changeStatusOfTask(inSection: indexPath.section, row: indexPath.row, to: .denied)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            denieAction.backgroundColor = .denieColor
            return UISwipeActionsConfiguration(actions: [denieAction])
            
        default:
            
            let removeAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, _) in
                self.viewModel.removeTask(inSection: indexPath.section, row: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return UISwipeActionsConfiguration(actions: [removeAction])
            
        }
        
        
    }
    
    //Left Swipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard viewModel.getState() == .waitingTasks else { return nil }
        
        let completeAciton = UIContextualAction(style: .destructive, title: "Выполнено") { (_, _, _) in
            self.viewModel.changeStatusOfTask(inSection: indexPath.section, row: indexPath.row, to: .completed)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        completeAciton.backgroundColor = .completeColor
        return UISwipeActionsConfiguration(actions: [completeAciton])
    }
    
}


//MARK: NewTaskView Delegate
extension TableTasksView: NewTaskViewDelegate {
    func saveTask(taskItem: NewTaskViewItem) {
        viewModel.saveNewTask(withName: taskItem.getName())
        tableView.reloadData()
    }
}
