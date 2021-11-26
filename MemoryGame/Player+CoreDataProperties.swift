//
//  Player+CoreDataProperties.swift
//  MemoryGame
//
//  Created by Afnan Theb on 22/04/1443 AH.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var results: [String]?
    @NSManaged public var username: String?

}

extension Player : Identifiable {

}
