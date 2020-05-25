//
//  NewTaskView.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 24.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import SnapKit


protocol NewTaskViewDelegate {
    func saveTask(taskItem: NewTaskViewItem)
}


final class NewTaskView: UIViewController, NewTaskViewProtocol {
    
    
    private var viewModel: NewTaskViewModelProtocol!
    var delegate: NewTaskViewDelegate!
    
    
    private var saveItem: UIBarButtonItem!
    private var cancelItem: UIBarButtonItem!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var tfName: UITextField!
    
    private var viewNotificationSwitchBackground: UIView!
    private var labNotify: UILabel!
    private var switchNotify:  UISwitch!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewTaskViewModel()
        
        view.setNeedsUpdateConstraints()
        
        setupView()
        setupScrollView()
        setupContentView()
        setupTfName()
        setupRecognizers()
        setupViewNotificationSwitchBackground()
        setupLabNotify()
        setupSwitchNotify()
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfName.becomeFirstResponder()
    }
    
    override func updateViewConstraints() {
        
        makeConstraintsScrollView()
        makeConstraintsContentView()
        makeConstraintsTfName()
        makeConstraintsViewNotificationSwitchBackground()
        makeConstraintsLabNotify()
        makeConstraintsSwitchNotify()
        super.updateViewConstraints()
    }
    
    
    //MARK: User Actions
    @objc private func viewTapped() {
        view.endEditing(true)
    }
    
    @objc private func saveItemTapped() {
        guard let name = tfName.text else { return }
        delegate.saveTask(taskItem: NewTaskViewItem(name: name))
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func tfNameTextChanged() {
        saveItem.isEnabled = !(tfName.text?.isEmpty ?? true)
    }
    
}


//MARK: UITextFieldDelegate
extension NewTaskView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//MARK: SETUP VIEW
extension NewTaskView {
    
    private func setupView() {
        title = viewModel.getViewTitle()
        view.backgroundColor = .systemBackground
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
    }
    
    private func setupContentView() {
        contentView = UIView()
        scrollView.addSubview(contentView)
    }
    
    private func setupTfName() {
        tfName = UITextField()
        tfName.placeholder = "Название"
        tfName.textAlignment = .center
        tfName.adjustsFontSizeToFitWidth = true
        tfName.font = .systemFont(ofSize: 24)
        
        tfName.delegate = self
        tfName.addTarget(self, action: #selector(tfNameTextChanged), for: .editingChanged)
        
        contentView.addSubview(tfName)
    }
    
    private func setupRecognizers() {
        let rec = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        scrollView.addGestureRecognizer(rec)
    }
    
    private func setupNavigationBar() {
        saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItemTapped))
        navigationItem.setRightBarButton(saveItem, animated: true)
        saveItem.isEnabled = false
        
        cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelItemTapped))
        navigationItem.setLeftBarButton(cancelItem, animated: true)
    }
    
    private func setupViewNotificationSwitchBackground() {
        viewNotificationSwitchBackground = UIView()
        viewNotificationSwitchBackground.backgroundColor = .secondarySystemBackground
        viewNotificationSwitchBackground.layer.cornerRadius = 16
        
        contentView.addSubview(viewNotificationSwitchBackground)
    }
    
    private func setupLabNotify() {
        labNotify = UILabel()
        labNotify.text = "Уведомление"
        
        viewNotificationSwitchBackground.addSubview(labNotify)
    }
    
    private func setupSwitchNotify() {
        switchNotify = UISwitch()
        switchNotify.setOn(false, animated: false)
        
        viewNotificationSwitchBackground.addSubview(switchNotify)
    }
    
    
}


//MARK: Constraints
extension NewTaskView {
    
    private func makeConstraintsScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    private func makeConstraintsContentView() {
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(self.view.bounds.width)
            make.height.equalTo(self.view.bounds.inset(by: self.view.safeAreaInsets).height)
        }
    }
    
    private func makeConstraintsTfName() {
        tfName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(24)
        }
    }
    
    private func makeConstraintsViewNotificationSwitchBackground() {
        viewNotificationSwitchBackground.snp.makeConstraints { (make) in
            make.top.equalTo(tfName.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
    }
    
    private func makeConstraintsLabNotify() {
        labNotify.snp.makeConstraints { (make) in
            make.leading.equalTo(self.viewNotificationSwitchBackground).offset(16)
            make.centerY.equalTo(self.viewNotificationSwitchBackground)
        }
    }
    
    private func makeConstraintsSwitchNotify() {
        switchNotify.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.viewNotificationSwitchBackground).offset(-8)
            make.centerY.equalTo(self.viewNotificationSwitchBackground)
        }
    }
    
    
}
