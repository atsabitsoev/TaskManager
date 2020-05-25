//
//  NavigationBarSegment.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


enum NavigationBarSegment: Int {
    case waiting = 0
    case completed = 1
    case denied = 2
    
    func image() -> UIImage {
        switch self {
        case .waiting: return UIImage(named: "waiting")!
        case .completed: return UIImage(named: "completed")!
        case .denied: return UIImage(named: "denied")!
        }
    }
}
