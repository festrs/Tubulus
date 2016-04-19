//
//  ProtocolCoreDataTableViewController.swift
//  Boleto
//
//  Created by Felipe Dias Pereira on 2016-03-14.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import CoreData

public protocol CoreDataTableViewControllerProtocol: UITableViewDataSource {
    
    func performFetch()
    var fetchedResultsController:NSFetchedResultsController? {get set}
    // MARK: - Table view data source
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
}
