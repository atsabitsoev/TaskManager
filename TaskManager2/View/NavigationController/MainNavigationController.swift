//
//  MainNavigationController.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


final class MainNavigationController: UINavigationController {
    
    
    override var navigationBar: UINavigationBar {
        let bar = super.navigationBar
        bar.isTranslucent = false
        bar.shadowImage = UIImage()
        return bar
    }
}
