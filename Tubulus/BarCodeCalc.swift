//
//  BarCodeCalc.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-02-28.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import Foundation


public struct StructBarCode {
    
    var barCode: String?
    var barCodeLine: String?
    var value: Float?
    var expDate: NSDate?
    
    init(barCode: String?, barCodeLine: String?, value: Float?, expDate: NSDate?){
        self.barCode = barCode
        self.barCodeLine = barCodeLine
        self.value = value
        self.expDate = expDate
    }
    
    func toStringJSON()->String{
        let date = NSDate()
        let month = date.getComponent(.Month)!
        let year = date.getComponent(.Year)!
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        if expDate != nil{
            return "{\"id\":\"\(barCode!)\",\"bar_code_line\":\"\(barCodeLine!)\",\"value\":\(value!),\"mes\":\"\(formatter.stringFromNumber((expDate?.getComponent(.Month))!)!)/\((expDate?.getComponent(.Year))!)\",\"exp_date\":\(expDate!.timeIntervalSince1970),\"created_at\":\"\(NSDate().timeIntervalSince1970)\"}"
        }else{
            return "{\"id\":\"\(barCode!)\",\"bar_code_line\":\"\(barCodeLine!)\",\"value\":\(value!),\"mes\":\"\(formatter.stringFromNumber(month)!)/\(year)\",\"created_at\":\"\(NSDate().timeIntervalSince1970)\"}"
        }
    }
}

public class BarCodeCalc{
    
    enum BarCodeCalcError: ErrorType {
        case Not44Characters
        case DateNotPicked
    }
    
    public func extractDataFromBarCode(barCode: String) throws -> StructBarCode {
        
        let barCodeLine = try calcStringFromBarCode(barCode)
        let valueString = barCode.substringWithRange(5, end: 15)
        let index = valueString.characters.count-2
        let value = valueString.insert(".", ind: index)
        var valueF = Float(value)
        var expDate:NSDate? = nil
        if !verifyModulo11(barCode) {
            if Int(barCode.substringWithRange(5, end: 9)) == 0{
                valueF = 0.0
            }else{
                let valueString = barCode.substringWithRange(9, end: 19)
                let index = valueString.characters.count-2
                let value = valueString.insert(".", ind: index)
                valueF = Float(value)
            }
            let days:Int = Int(barCode.substringWithRange(5, end: 9))!
            if days != 0{
                // date started 7/10/1997 - 1/1/1970  = 10141
                expDate = NSDate(timeInterval: Double(60*60*24*days), sinceDate: NSDate(timeIntervalSince1970: Double(10141*60*60*24)))
            }
        }
        return StructBarCode(barCode: barCode, barCodeLine: barCodeLine, value: valueF, expDate: expDate)
    }
    
    //    Posição 01-03 = Identificação do banco (exemplo: 001 = Banco do Brasil)
    //    Posição 04-04 = Código de moeda (exemplo: 9 = Real)
    //    Posição 05-09 = 5 primeiras posições do campo livre (posições 20 a 24 do código de barras)
    //    Posição 10-10 = Dígito verificador do primeiro campo
    //    Posição 11-20 = 6ª a 15ª posições do campo livre (posições 25 a 34 do código de barras)
    //    Posição 21-21 = Dígito verificador do segundo campo
    //    Posição 22-31 = 16ª a 25ª posições do campo livre (posições 35 a 44 do código de barras)
    //    Posição 32-32 = Dígito verificador do terceiro campo
    //    Posição 33-33 = Dígito verificador geral (posição 5 do código de barras)
    //    Posição 34-37 = Fator de vencimento (posições 6 a 9 do código de barras)
    //    Posição 38-47 = Valor nominal do título (posições 10 a 19 do código de barras)
    public func calcStringFromBarCode(barCode: String) throws -> String{
        
        guard barCode.characters.count == 44 else { throw BarCodeCalcError.Not44Characters }
        
        let campo1 = barCode.substringWithRange(0, end: 4) + barCode.substringWithRange(19, end: 20) + barCode.substringWithRange(20, end: 24)
        let campo2 = barCode.substringWithRange(24, end: 29) + barCode.substringWithRange(29, end: 34)
        let campo3 = barCode.substringWithRange(34, end: 39) + barCode.substringWithRange(39, end: 44)
        let campo4 = barCode.substringWithRange(4, end: 5)
        let campo5 = barCode.substringWithRange(5, end: 19)
        
        // verificador de conta consumo
        if verifyModulo11(barCode) {
            let field1 = barCode.substringWithRange(0, end: 11) + modulo10(barCode.substringWithRange(0, end: 11)).description
            let field2 = barCode.substringWithRange(11, end: 22) + modulo10(barCode.substringWithRange(11, end: 22)).description
            let field3 = barCode.substringWithRange(22, end: 33) + modulo10(barCode.substringWithRange(22, end: 33)).description
            let field4 = barCode.substringWithRange(33, end: 44) + modulo10(barCode.substringWithRange(33, end: 44)).description
            
            return field1+field2+field3+field4
        }else{
            return campo1+self.modulo10(campo1).description+campo2+self.modulo10(campo2).description+campo3+self.modulo10(campo3).description+campo4+campo5
        }
    }
    
    // verificador de conta consumo
    public func verifyModulo11(barCode: String) ->Bool{
        return modulo11(barCode.substringWithRange(0, end: 4) + barCode.substringWithRange(5, end: barCode.characters.count)) != Int(barCode.substringWithRange(4, end: 5))
    }
    
    public func modulo10(numero: String) -> Int{
        var soma  = 0
        var peso  = 2
        var contador = (numero.characters.count - 1)
        while (contador >= 0) {
            var multiplicacao = Int(numero.substringWithRange(contador, end: contador+1))! * peso
            if (multiplicacao >= 10) {multiplicacao = 1 + (multiplicacao-10);}
            soma = soma + multiplicacao;
            if (peso == 2) {
                peso = 1;
            } else {
                peso = 2;
            }
            contador -= 1;
        }
        var digito = 10 - (soma % 10);
        if (digito == 10)
        {
            digito = 0;
        }
        return digito;
    }
    
    public func modulo11(numero: String) -> Int{
        var soma = 0
        var peso = 2
        let base = 9
        var contador = (numero.characters.count - 1)
        while (contador >= 0){
            soma = soma + Int(numero.substringWithRange(contador, end: contador+1))! * peso
            if peso < base {
                peso += 1
            }else{
                peso = 2
            }
            contador -= 1;
        }
        var digito = 11 - (soma % 11)
        if digito > 9{
            digito = 0
        }
        if digito == 0{
            digito = 1
        }
        return digito
    }
}