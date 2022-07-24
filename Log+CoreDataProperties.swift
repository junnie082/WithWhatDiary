//
//  Log+CoreDataProperties.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/21.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var date: String?
    @NSManaged public var image: Data?
    @NSManaged public var logID: String?
    @NSManaged public var photoID: String?
    @NSManaged public var title: String?
    @NSManaged public var userID: String?
    @NSManaged public var what: String?
    @NSManaged public var with: String?

}

extension Log : Identifiable {

}
