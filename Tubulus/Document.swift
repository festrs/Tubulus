//
//  Document.swift
//  Tubulus
//
//  Created by Felipe Dias Pereira on 2016-04-15.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import Foundation
import CoreData


class Document: NSManagedObject,Groupable,Comparable {

    func sameGroupAs(otherDocument: Document) -> Bool {
        let f = self.mes
        let s = otherDocument.mes
        
        return f == s
    }
}

func == (lhs: Document, rhs: Document) -> Bool {
    return lhs.mes == rhs.mes
}

func < (lhs: Document, rhs: Document) -> Bool {
    return lhs.mes < rhs.mes
}