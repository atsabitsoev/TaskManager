//
//  NotificationService.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 25.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


final class NotificationService: NotificationProvider {
    
    func createNotification(withBody body: String, date: Date) {
        print("Создано напоминание с текстом \(body), дата: \(date.toString(format: "dd.MM.yyyy"))")
    }
}
