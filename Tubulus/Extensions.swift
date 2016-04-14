//
//  Constants.swift
//  NFC-E
//
//  Created by Jáder Borba Nunes on 2/13/16.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//
import Foundation

let monthsName: [Int:String] = [1:"JAN",2:"FEV",3:"MAR",4:"ABR",5:"MAIO",6:"JUN",7:"JUL",8:"AGO",9:"SET",10:"OUT",11:"NOV",12:"DEZ"]

let notificationIdentifier = "didChangedCoreData"
let notificationMenuIdentifier = "needReloadMenu"

enum TypeConfig : Int {
    case Day = 0, Hour = 1
}

public protocol Groupable {
    func sameGroupAs(otherPerson: Self) -> Bool
}

extension CollectionType {
    
    public typealias ItemType = Self.Generator.Element
    public typealias Grouper = (ItemType, ItemType) -> Bool
    
    public func groupBy(grouper: Grouper) -> [[ItemType]] {
        var result : Array<Array<ItemType>> = []
        
        var previousItem: ItemType?
        var group = [ItemType]()
        
        for item in self {
            // Current item will be the next item
            defer {previousItem = item}
            
            // Check if it's the first item
            guard let previous = previousItem else {
                group.append(item)
                continue
            }
            
            if grouper(previous, item) {
                // Item in the same group
                group.append(item)
            } else {
                // New group
                result.append(group)
                group = [ItemType]()
                group.append(item)
            }
        }
        
        result.append(group)
        
        return result
    }
    
}

extension CollectionType where Self.Generator.Element: Groupable {
    
    public func group() -> [[Self.Generator.Element]] {
        return self.groupBy { $0.sameGroupAs($1) }
    }
    
}

extension CollectionType where Self.Generator.Element: Comparable {
    
    public func uniquelyGroupBy(grouper: (Self.Generator.Element, Self.Generator.Element) -> Bool) -> [[Self.Generator.Element]] {
        let sorted = self.sort()
        return sorted.groupBy(grouper)
    }
    
}

extension NSDate {
    func getComponent(component:NSCalendarUnit) -> Int?{
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(component, fromDate: self) {
                return comp.valueForComponent(component)
        } else {
            return nil
        }
    }
}

extension NSNumber {
    func toMaskReais() ->String?{
        let stringValue = self.description.stringByReplacingOccurrencesOfString(".", withString: ",")
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 4
        return "R$\(stringValue)"
    }
    func maskToCurrency() ->String?{
        let stringValue = self.description.stringByReplacingOccurrencesOfString(".", withString: ",")
        return stringValue
    }
}

extension String
{
    func substringWithRange(start: Int, end: Int) -> String
    {
        if (start < 0 || start > self.characters.count)
        {
            print("start index \(start) out of bounds")
            return ""
        }
        else if end < 0 || end > self.characters.count
        {
            print("end index \(end) out of bounds")
            return ""
        }
        let range = self.startIndex.advancedBy(start) ..< self.startIndex.advancedBy(end)
        
        return self.substringWithRange(range)
    }
    
    func substringWithRange(start: Int, location: Int) -> String
    {
        if (start < 0 || start > self.characters.count)
        {
            print("start index \(start) out of bounds")
            return ""
        }
        else if location < 0 || start + location > self.characters.count
        {
            print("end index \(start + location) out of bounds")
            return ""
        }
        let range = self.startIndex.advancedBy(start) ..< self.startIndex.advancedBy(start + location)
        return self.substringWithRange(range)
    }
    
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    func convertStringToDictionary() -> [String:AnyObject]! {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}