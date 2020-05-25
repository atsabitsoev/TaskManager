//
//  SimpleTaskCell.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import SnapKit


final class SimpleTaskCell: UITableViewCell, TaskCell {
    
    
    init(viewModel: TaskCellViewModel) {
        let identifier = "SimpleTaskCell"
        super.init(style: .default, reuseIdentifier: identifier)
        self.viewModel = viewModel
        setupCell()
    }
    
    
    private let labName = UILabel()
    
    
    private var viewModel: TaskCellViewModel! {
        didSet {
            setupCell()
        }
    }
    
    
    private func setupCell() {
        contentView.addSubview(labName)
        setNeedsUpdateConstraints()
        labName.numberOfLines = 0
        labName.text = viewModel.getTaskName()
    }
    
    
    override func updateConstraints() {
        
        labName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
        }
        super.updateConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
