//
//  AlertHandler.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-03-05.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import DATAStack

class AlertHandler:FPHandlesMOC {
    
    static let sharedInstance = AlertHandler()
    private var dataStack:DATAStack!
    lazy var plist = Plist(name: "Config")
    
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    func cancelAllNotification(){
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func enableAllNotifications(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

            let fetchRequestFirst = NSFetchRequest(entityName: "Document")
            do {
                let results = try self.dataStack.mainContext.executeFetchRequest(fetchRequestFirst) as! [Document]
                if results.count > 0 {
                    for doc:Document in results {
                        self.createLocalNotification(doc)
                    }
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        });
    }
    
    func createLocalNotification(document: Document){
        // verify the date if < them actual dont create the alert
        guard document.expDate!.timeIntervalSinceDate(NSDate()) > 0 else { return }
        if isToSetAlarm() {
            // create a corresponding local notification
            let notification = UILocalNotification()
            notification.alertAction = "Abrir" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
            var fireDate = document.expDate
            let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            if getDayToNotify() != 0{
                guard let day = getDayToNotify() else { return }
                fireDate = calendar?.dateBySettingUnit(.Day, value: Int(day), ofDate: fireDate!, options: [])
            }
            guard let hour = getHourToNotify() else { return }
            fireDate = calendar?.dateBySettingHour(hour, minute: 00, second: 00, ofDate: fireDate!, options: [])
            notification.fireDate = fireDate
            notification.soundName = UILocalNotificationDefaultSoundName // play default sound
            notification.userInfo = ["RemoteID": document.remoteID! ]
            notification.category = "DOCUMENT_CATEGORY"
            notification.alertBody = "Você tem um Boleto vencendo heim \(document.expDate?.getComponent(.Day))/\(document.expDate?.getComponent(.Month))"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func isToSetAlarm() -> Bool{
        if let plist = self.plist {
            let dict = plist.getMutablePlistFile()
            return dict!["set_alarm"] as! Bool
        } else {
            print("Unable to get Plist")
        }
        return false
    }
    
    func getHourToNotify() -> Int?{
        if let plist = self.plist {
            let dict = plist.getMutablePlistFile()
            return dict!["alarm_hour"] as? Int
        } else {
            print("Unable to get Plist")
            return nil
        }
    }
    
    func getDayToNotify() -> Int?{
        if let plist = self.plist {
            let dict = plist.getMutablePlistFile()
            return dict!["days_to_alarm"] as? Int
        } else {
            print("Unable to get Plist")
            return nil
        }
    }
    
    func receiveDataStack(incomingDataStack: DATAStack) {
        self.dataStack = incomingDataStack
    }
}