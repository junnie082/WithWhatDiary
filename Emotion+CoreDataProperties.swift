//
//  Emotion+CoreDataProperties.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/21.
//
//

import Foundation
import CoreData


extension Emotion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emotion> {
        return NSFetchRequest<Emotion>(entityName: "Emotion")
    }

    @NSManaged public var emotion: String?

}

extension Emotion : Identifiable {

}
