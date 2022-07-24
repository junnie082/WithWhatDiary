//
//  User+CoreDataProperties.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var registerDate: Date?

}

extension User : Identifiable {

}
