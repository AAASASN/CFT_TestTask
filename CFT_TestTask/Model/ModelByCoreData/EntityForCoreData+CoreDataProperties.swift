//
//  EntityForCoreData+CoreDataProperties.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 25.02.2023.
//
//

import Foundation
import CoreData


extension EntityForCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityForCoreData> {
        return NSFetchRequest<EntityForCoreData>(entityName: "EntityForCoreData")
    }

    @NSManaged public var noteArrayAsData: Data?

}

extension EntityForCoreData : Identifiable {

}
