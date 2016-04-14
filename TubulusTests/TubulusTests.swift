//
//  TubulusTests.swift
//  TubulusTests
//
//  Created by Felipe Dias Pereira on 2016-04-14.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import XCTest
@testable import Tubulus

class TubulusTests: XCTestCase {
    
    var barCodeCalc:BarCodeCalc!
    
    override func setUp() {
        super.setUp()
        barCodeCalc = BarCodeCalc()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBarCodeCalc() {
        let barCodeLine = "846800000008518300820892999544882304314976945993"
        let barCode = "84680000000518300820899995448823031497694599"
        do{
            let barCodeResult = try barCodeCalc.calcStringFromBarCode(barCode)
            XCTAssertEqual(barCodeLine,barCodeResult)
        }catch{
            print("Error")
        }
    }
    
    
    func testBarCodeModulo10(){
        let inputString = "261533"
        XCTAssertEqual("4",barCodeCalc.modulo10(inputString).description)
    }
    
    func testBarCodeModulo11(){
        let inputString = "261533"
        XCTAssertEqual("9",barCodeCalc.modulo11(inputString).description)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
