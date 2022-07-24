//
//  Photo+CoreDataProperties.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/21.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: Data?
    @NSManaged public var photoID: String?

}

extension Photo : Identifiable {

}
