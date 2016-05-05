//
//  Document+CoreDataProperties.swift
//  Tubulus
//
//  Created by Felipe Dias Pereira on 2016-04-15.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Document {

    @NSManaged var barCodeLine: String?
    @NSManaged var createdAt: NSDate?
    @NSManaged var expDate: NSDate?
    @NSManaged var mes: String?
    @NSManaged var remoteID: String?
    @NSManaged var bank: String?
    @NSManaged var value: NSNumber?

}
