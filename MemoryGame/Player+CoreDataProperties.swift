//
//  Player+CoreDataProperties.swift
//  MemoryGame
//
//  Created by Afnan Theb on 23/04/1443 AH.
//
//

import UIKit
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var score: Set<Score>?

}

// MARK: Generated accessors for score
extension Player {

    @objc(addScoreObject:)
    @NSManaged public func addToScore(_ value: Score)

    @objc(removeScoreObject:)
    @NSManaged public func removeFromScore(_ value: Score)

    @objc(addScore:)
    @NSManaged public func addToScore(_ values: NSSet)

    @objc(removeScore:)
    @NSManaged public func removeFromScore(_ values: NSSet)

}

extension Player : Identifiable {

}
