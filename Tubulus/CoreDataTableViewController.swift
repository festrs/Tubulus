//
//  CoreDataTableViewController.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-02-27.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UIViewController, CoreDataTableViewControllerProtocol {
    var coreDataTableView:UITableView!
    private var _fetchedResultsController:NSFetchedResultsController?
    
    var fetchedResultsController:NSFetchedResultsController?{
        get {
            return _fetchedResultsController
        }
        set (newValue){
            _fetchedResultsController = newValue
            if self.coreDataTableView != nil {
                self.performFetch()
            }
        }
    }
    
    func performFetch(){
        do{
            try self.fetchedResultsController!.performFetch()
            coreDataTableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (self.fetchedResultsController!.sections != nil){
            return (self.fetchedResultsController!.sections?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController!.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController!.sections {
            let currentSection = sections[section]
            return currentSection.name
        }
        return nil
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return self.fetchedResultsController!.sectionForSectionIndexTitle(title, atIndex: index)
    }
    
//    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return self.fetchedResultsController.sectionIndexTitles
//    }
    
    //MARK - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.coreDataTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch(type){
        case .Insert:
            self.coreDataTableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case .Delete:
            self.coreDataTableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
            break
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type{
        case .Insert:
            self.coreDataTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case .Delete:
            self.coreDataTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case .Update:
            self.coreDataTableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case .Move:
            self.coreDataTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            self.coreDataTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.coreDataTableView.endUpdates()
    }
}
