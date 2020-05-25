//
//  CoreDataSavable.swift
//  TaskManager2
//
//  Created by Ацамаз Бицоев on 23.05.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import CoreData


protocol CoreDataUsable {
    func getCoreDataId() -> NSManagedObjectID?
    func setCoreDataId(_ id: NSManagedObjectID?)
}
