//
//  Score+CoreDataProperties.swift
//  MemoryGame
//
//  Created by Afnan Theb on 23/04/1443 AH.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var result: String?
    @NSManaged public var ofPlayer: Player?

}

extension Score : Identifiable {

}
