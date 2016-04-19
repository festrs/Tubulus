//
//  ConfigTableViewController.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-03-06.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import DATAStack

class ConfigTableViewController: UITableViewController,FPHandlesMOC {

    //MARK: Variables
    @IBOutlet var contentTableView: UITableView!
    @IBOutlet weak var detailDaysAlertLabel: UILabel!
    @IBOutlet weak var detailHourAlertLabel: UILabel!
    @IBOutlet weak var dayAlertTitleLabel: UILabel!
    @IBOutlet weak var hourAlertTitleLabel: UILabel!
    @IBOutlet weak var dayTableViewCell: UITableViewCell!
    @IBOutlet weak var hourTableViewCell: UITableViewCell!
    lazy var alertHandler:AlertHandler = AlertHandler.sharedInstance
    var plist:Plist?
    
    //MARK: - APP Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.title = "Configurações"
        self.dayAlertTitleLabel.text = "Dia do alerta"
        self.hourAlertTitleLabel.text = "Hora do alerta"
        
        plist = alertHandler.plist
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //plist values
        if alertHandler.getDayToNotify() == 0 {
            self.detailDaysAlertLabel.text = "no dia do vencimento"
        } else {
            self.detailDaysAlertLabel.text = alertHandler.getDayToNotify()!.description + " dias antes"
        }
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        self.detailHourAlertLabel.text = formatter.stringFromNumber(alertHandler.getHourToNotify()!)! + ":00"
    }
    
    //MARK: - Actions
    @IBAction func didChangeSwitchAlert(sender: UISwitch) {
        if sender.on {
            self.dayTableViewCell.userInteractionEnabled = true
            self.hourTableViewCell.userInteractionEnabled = true
            self.dayAlertTitleLabel.alpha = 1
            self.hourAlertTitleLabel.alpha = 1
            alertHandler.enableAllNotifications()
        }else{
            self.dayTableViewCell.userInteractionEnabled = false
            self.hourTableViewCell.userInteractionEnabled = false
            self.dayAlertTitleLabel.alpha = 0.439216
            self.hourAlertTitleLabel.alpha = 0.439216
            alertHandler.cancelAllNotification()
        }
    }
    
    //MARK: - TableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != 0{
            performSegueWithIdentifier("toDetailConfig", sender: tableView.cellForRowAtIndexPath(indexPath))
        }
    }
    
    func receiveDataStack(incomingDataStack: DATAStack) {
        alertHandler.receiveDataStack(incomingDataStack)
    }
    
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailConfig"{
            if segue.destinationViewController.isKindOfClass(ConfigDetailTableViewController){
                let vc = segue.destinationViewController as! ConfigDetailTableViewController
                if sender!.isKindOfClass(UITableViewCell){
                    let cell = sender as! UITableViewCell
                    vc.plist = plist
                    vc.alertHandler = self.alertHandler
                    if cell.tag == 1{
                        vc.typeDetail = TypeConfig.Day
                    }else if cell.tag == 2{
                        vc.typeDetail = TypeConfig.Hour
                    }
                }
            }
        }
    }
    
}
