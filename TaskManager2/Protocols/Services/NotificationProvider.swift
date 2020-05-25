//
//  NotificationProvider.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 25.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


protocol NotificationProvider {
    
    func createNotification(withBody body: String, date: Date)
}
