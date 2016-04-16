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
    let barCodeLine = "846800000008518300820892999544882304314976945993"
    let barCodeLine2 = "00190000090261671404083600386185767190000016398"
    let barCode = "84680000000518300820899995448823031497694599"
    let barCode2 = "00197671900000163980000002616714048360038618"
    let date = NSDate(timeIntervalSince1970: 1456704000) // 29/02/2016 00:00:00
    var mockStructBarCodeType1:StructBarCode!
    var mockStructBarCodeType2:StructBarCode!
    
    override func setUp() {
        super.setUp()
        barCodeCalc = BarCodeCalc()
        mockStructBarCodeType1 = StructBarCode(barCode: barCode, barCodeLine: barCodeLine, value: 51.83, expDate: nil)
        mockStructBarCodeType2 = StructBarCode(barCode: barCode2, barCodeLine: barCodeLine2, value: 163.98, expDate: date)
    }
    
    override func tearDown() {
        barCodeCalc = nil
        mockStructBarCodeType1 = nil
        mockStructBarCodeType2 = nil
        super.tearDown()
    }
    
    //boleto
    func testType2ExtractDataFromBarCode(){
        do {
            let barCodeStructTest = try barCodeCalc.extractDataFromBarCode(barCode2)
            XCTAssertEqual(barCodeStructTest.toStringJSON(),mockStructBarCodeType2.toStringJSON())
        }
        catch {
            XCTFail("error")
        }
    }
    
    // conta consuma
    func testType1ExtractDataFromBarCode(){
        do {
            let barCodeStructTest = try barCodeCalc.extractDataFromBarCode(barCode)
            XCTAssertEqual(barCodeStructTest.toStringJSON(),mockStructBarCodeType1.toStringJSON())
        }
        catch {
            XCTFail("error")
        }
    }
    
    func testNot44CharactersFromBarCode(){
        let barCodeError = "0019767190000016398000000261671404836003861812314"
        do {
            try barCodeCalc.extractDataFromBarCode(barCodeError)
        }
        catch let e as BarCodeCalcError {
            XCTAssertEqual(e, BarCodeCalcError.Not44Characters(message: "Not 44 Characters"))
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testBarCodeCalc() {
        do{
            let barCodeResult = try barCodeCalc.calcStringFromBarCode(barCode)
            XCTAssertEqual(barCodeLine,barCodeResult)
        }catch{
            print("Error")
        }
    }
    
    func testVerifyModulo11(){
         // boleto cobrança
        XCTAssertFalse(barCodeCalc.verifyModulo11(barCode2))
        XCTAssertTrue(barCodeCalc.verifyModulo11(barCode)) // boleto conta consumo
    }
    
    func testBarCodeModulo10(){
        let inputString = "261533"
        XCTAssertNotEqual("3", barCodeCalc.modulo10(inputString).description)
        XCTAssertEqual("4",barCodeCalc.modulo10(inputString).description)
    }
    
    func testBarCodeModulo11(){
        let inputString = "261533"
        XCTAssertNotEqual("0", barCodeCalc.modulo11(inputString).description)
        XCTAssertEqual("9",barCodeCalc.modulo11(inputString).description)
    }
    
}
