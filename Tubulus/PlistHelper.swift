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

    var sourcePath:String? {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist") else { return .None }
        return path
    }
    var _destPath:String?
    var destPath:String? {
        mutating get {
            guard sourcePath != .None else { return .None }
            let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            _destPath = (dir as NSString).stringByAppendingPathComponent("\(name).plist")
            return _destPath
        }
        set(newValue){
            _destPath = newValue
        }
    }
    
    init?(name:String) {

        self.name = name
        let fileManager = NSFileManager.defaultManager()
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExistsAtPath(source) else { return nil }

        if !fileManager.fileExistsAtPath(destination) {
            do {
                try fileManager.copyItemAtPath(source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    mutating func getValuesInPlistFile() -> NSDictionary?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let dict = NSDictionary(contentsOfFile: destPath!) else { return .None }
            return dict
        } else {
            return .None
        }
    }

    mutating func getMutablePlistFile() -> NSMutableDictionary?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let dict = NSMutableDictionary(contentsOfFile: destPath!) else { return .None }
            return dict
        } else {
            return .None
        }
    }

    mutating func addValuesToPlistFile(dictionary:NSDictionary) throws {
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
