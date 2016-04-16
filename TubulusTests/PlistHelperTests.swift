//
//  PlistHelperTests.swift
//  Tubulus
//
//  Created by Felipe Dias Pereira on 2016-04-15.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import XCTest
@testable import Tubulus

class PlistHelperTests: XCTestCase {
    
    var plist:Plist? = nil
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        let dict = createPlist()
        
        XCTAssertNotNil(dict)
        // reset to default
        dict?.setValue(0, forKey: "days_to_alarm")
        
        do {
            try plist!.addValuesToPlistFile(dict!)
        } catch {
            XCTFail()
        }
        
        plist = nil
        super.tearDown()
    }
    
    func testCreatePlist() -> Void {
        XCTAssertNil(plist)
        
        plist = Plist(name: "Config")
        
        XCTAssertNotNil(plist)
        
        plist = Plist(name: "Con")
        
        XCTAssertNil(plist)
    }
    
    func createPlist()-> NSDictionary?{
        plist = Plist(name: "Config")
        
        XCTAssertNotNil(plist)
        
        // default value
        return plist!.getMutablePlistFile()
    }
    
    func testGetAlarmHourPlist() -> Void {
        plist = Plist(name: "Config")
        
        XCTAssertNotNil(plist)
        
        // default value 
        let dict = plist!.getMutablePlistFile()
        
        XCTAssertNotNil(dict)
        
        let alarm_hour = dict!["alarm_hour"] as? Int
        
        XCTAssertNotNil(alarm_hour)
        
        XCTAssertEqual(11, alarm_hour)
        
    }
    
    func testGetDaysToAlarmPlist() -> Void {
        
        let dict = createPlist()
        
        XCTAssertNotNil(dict)
        
        let days_to_alarm = dict!["days_to_alarm"] as? Int
        
        XCTAssertNotNil(days_to_alarm)
        
        XCTAssertEqual(0, days_to_alarm)
    }
    
    func testGetSetAlarmPlist() -> Void {
        
        let dict = createPlist()
        
        XCTAssertNotNil(dict)
        
        let set_alarm = dict!["set_alarm"] as? Bool
        
        XCTAssertNotNil(set_alarm)
        
        XCTAssertTrue(set_alarm!)
    }
    
    func testSetPlist() -> Void {
        
        let dict = createPlist()
        
        XCTAssertNotNil(dict)
        
        dict?.setValue(2, forKey: "days_to_alarm")
        
        do {
            try plist!.addValuesToPlistFile(dict!)
        } catch {
            XCTFail()
        }
        
        let days_to_alarm = dict!["days_to_alarm"] as? Int
        
        XCTAssertNotNil(days_to_alarm)
        
        XCTAssertEqual(2, days_to_alarm)
        
    }
    
    
    func testSetThrowsPlist() -> Void{
        let dict = createPlist()
        
        XCTAssertNotNil(dict)
        
        dict?.setValue(2, forKey: "days_to_alarm")
        
        plist!.destPath = nil
        
        do {
            try plist!.addValuesToPlistFile(dict!)
        } catch let e as PlistError {
            XCTAssertEqual(e, PlistError.FileNotWritten(message: "File not written successfully"))
        } catch{
            XCTFail()
        }
    }

}
