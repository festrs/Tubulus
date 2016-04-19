//
//  ConfigDetail.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-03-07.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class ConfigDetailTableViewController: UITableViewController {
    var typeDetail:TypeConfig!
    var items:[Int] = []
    var plist:Plist?
    var alertHandler:AlertHandler!
    var selectedIndexPath:NSIndexPath!
    @IBOutlet var contentTableView: UITableView!
    
    //MARK: - App life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTableView.tableFooterView = UIView(frame: CGRect.zero)
        if typeDetail == TypeConfig.Day{
            for index in 0 ... 8{
                items.append(index)
            }
        }else if typeDetail == TypeConfig.Hour{
            for index in 0 ... 23{
                items.append(index)
            }
        }
        if  self.plist != nil {
            let dict = self.plist?.getMutablePlistFile()
            if typeDetail == TypeConfig.Day{
                let day = dict!["days_to_alarm"] as! Int
                selectedIndexPath = NSIndexPath(forRow: day, inSection: 0)
            }else if typeDetail == TypeConfig.Hour{
                let hour = dict!["alarm_hour"] as! Int
                selectedIndexPath = NSIndexPath(forRow: hour, inSection: 0)
            }
        } else {
            print("Unable to get Plist")
        }
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return items.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailConfigCell", forIndexPath: indexPath)
            
            let item = items[indexPath.row]
            if typeDetail == TypeConfig.Day{
                cell.textLabel!.text = "Número de dias"
                if item == 0{
                    cell.detailTextLabel?.text = "no dia"
                }else{
                    cell.detailTextLabel?.text = item.description
                }
            }else if typeDetail == TypeConfig.Hour{
                cell.textLabel!.text = "Hora do alerta"
                let formatter = NSNumberFormatter()
                formatter.minimumIntegerDigits = 2
                cell.detailTextLabel?.text = formatter.stringFromNumber(item)! + ":00"
            }
            if selectedIndexPath == indexPath{
                cell.accessoryType = .Checkmark
            }else{
                cell.accessoryType = .None
            }
            return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if typeDetail == TypeConfig.Day{
            return "Número de dias antes do vencimento"
        }else if typeDetail == TypeConfig.Hour{
            return "Horário do alerta"
        }
        return ""
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        if (selectedIndexPath != nil && selectedIndexPath != indexPath){
            let oldCell = tableView.cellForRowAtIndexPath(selectedIndexPath)
            oldCell?.accessoryType = .None
        }
        selectedIndexPath = indexPath
        
        saveNewValue(indexPath.row)
    }
    
    //Mark: - Save function
    func saveNewValue(value: Int){
        if self.plist != nil {
            let dict = self.plist?.getMutablePlistFile()
            if typeDetail == TypeConfig.Day{
                dict!["days_to_alarm"] = value
            }else if typeDetail == TypeConfig.Hour{
                dict!["alarm_hour"] = value
            }
            do {
                try self.plist?.addValuesToPlistFile(dict!)
            } catch {
                print(error)
            }
        } else {
            print("Unable to get Plist")
        }
        if alertHandler != nil {
            alertHandler.cancelAllNotification()
            alertHandler.enableAllNotifications()
        }
    }
}
