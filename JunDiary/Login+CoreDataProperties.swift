//
//  Login+CoreDataProperties.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/21.
//
//

import Foundation
import CoreData


extension Login {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Login> {
        return NSFetchRequest<Login>(entityName: "Login")
    }


}

extension Login : Identifiable {

}
