//
//  PlistHelper.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-03-05.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Foundation


enum PlistError: ErrorType, Equatable {
    case FileNotWritten(message: String)
}

func ==(lhs: PlistError, rhs: PlistError) -> Bool {
    switch (lhs, rhs) {
    case (.FileNotWritten(let leftMessage), .FileNotWritten(let rightMessage)):
        return leftMessage == rightMessage
    }
}

struct Plist {

    let name:String

    var sourcePath:String?
    var destPath:String?
    
    init?(name:String, destPath:String?, sourcePath:String?) {
        self.name = name
        let fileManager = NSFileManager.defaultManager()
        self.sourcePath = sourcePath
        self.destPath = destPath
        guard fileManager.fileExistsAtPath(self.sourcePath!) else { return nil }
        if !fileManager.fileExistsAtPath(self.destPath!) {
            do {
                try fileManager.copyItemAtPath(self.sourcePath!, toPath: self.destPath!)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    init?(name:String) {
        self.name = name
        let fileManager = NSFileManager.defaultManager()
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist") else { return nil }
        self.sourcePath = path
        guard self.sourcePath != .None else { return nil }
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        self.destPath = (dir as NSString).stringByAppendingPathComponent("\(name).plist")
        guard fileManager.fileExistsAtPath(self.sourcePath!) else { return nil }
        if !fileManager.fileExistsAtPath(self.destPath!) {
            do {
                try fileManager.copyItemAtPath(self.sourcePath!, toPath: self.destPath!)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    func getValuesInPlistFile() -> NSDictionary?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let dict = NSDictionary(contentsOfFile: destPath!) else { return .None }
            return dict
        } else {
            return .None
        }
    }

    func getMutablePlistFile() -> NSMutableDictionary?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let dict = NSMutableDictionary(contentsOfFile: destPath!) else { return .None }
            return dict
        } else {
            return .None
        }
    }

    func addValuesToPlistFile(dictionary:NSDictionary) throws {
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            if !dictionary.writeToFile(destPath!, atomically: false) {
                throw PlistError.FileNotWritten(message: "File not written successfully")
            }
        } else {
            throw PlistError.FileNotWritten(message: "File not written successfully")
        }
    }
}
