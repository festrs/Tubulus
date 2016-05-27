//
//  MyUINavigationController.swift
//  ToDoAssignment3
//
//  Created by Felipe Dias Pereira on 2016-04-08.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import DATAStack

class NavigationController: UINavigationController, FPHandlesMOC {
    
    
    func receiveDataStack(incomingDataStack: DATAStack) {
        if let child = self.viewControllers.first as? FPHandlesMOC{
            child.receiveDataStack(incomingDataStack)
        }
        
        if let coreData = self.viewControllers.first as? CoreDataTableViewController{
            let fetchRequest = NSFetchRequest(entityName: "Document")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mes", ascending: false)]
            let fecthController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: incomingDataStack.mainContext, sectionNameKeyPath: "mes" , cacheName: nil)
            coreData.fetchedResultsController = fecthController
        }
    }

 
}
