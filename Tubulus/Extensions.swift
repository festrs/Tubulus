//
//  Constants.swift
//  NFC-E
//
//  Created by Jáder Borba Nunes on 2/13/16.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//
import Foundation

let monthsName: [Int:String] = [1:"JAN",2:"FEV",3:"MAR",4:"ABR",5:"MAIO",6:"JUN",7:"JUL",8:"AGO",9:"SET",10:"OUT",11:"NOV",12:"DEZ"]
let banks = [001 : "BANCO DO BRASIL S.A",
              003 : "BANCO DA AMAZONIA S.A.",
              004 : "BANCO DO NORDESTE DO BRASIL S.A.",
              021 : "BANESTES S.A BANCO DO ESTADO DO ESPIRITO SANTO",
              024 : "BANCO DE PERNAMBUCO S.A.:BANDEPE",
              025 : "BANCO ALFA S/A",
              027 : "BANCO DO ESTADO DE SANTA CATARINA S.A.",
              029 : "BANCO BANERJ S.A.",
              031 : "BANCO BEG S.A.",
              033 : "BANCO SANTANDER S.A.",
              034 : "BANCO DO ESTADO DO AMAZONAS S.A.",
              036 : "BANCO BRADESCO BBI S.A.",
              037 : "BANCO DO ESTADO DO PARA S.A.",
              038 : "BANCO BANESTADO S.A.",
              039 : "BANCO DO ESTADO DO PIAUI S.A. : BEP",
              040 : "BANCO CARGILL S.A",
              041 : "BANCO DO ESTADO DO RIO GRANDE DO SUL S.A.",
              044 : "BANCO BVA SA",
              045 : "BANCO OPPORTUNITY S.A.",
              047 : "BANCO DO ESTADO DE SERGIPE S.A.",
              062 : "HIPERCARD BANCO MÚLTIPLO S.A",
              063 : "BANCO IBI S.A : BANCO MULTIPLO",
              065 : "LEMON BANK BANCO MÚLTIPLO S..A",
              066 : "BANCO MORGAN STANLEY S.A",
              069 : "BPN BRASIL BANCO MÚLTIPLO S.A.",
              070 : "BRB : BANCO DE BRASILIA S.A.",
              072 : "BANCO RURAL MAIS S.A.",
              073 : "BB BANCO POPULAR DO BRASL S.A.",
              074 : "BANCO J.SAFRA S.A.",
              075 : "BANCO CR2 S.A.",
              076 : "BANCO KDB DO BRASIL S.A.",
              096 : "BANCO BM&F DE SERVIÇOS DE LIQUIDAÇÃO E CUSTÓDIA S.A.",
              104 : "Caixa Econômica Federal",
              116 : "BANCO ÚNICO S.A.",
              151 : "BANCO NOSSA CAIXA S.A",
              175 : "BANCO FINASA S.A.",
              184 : "BANCO ITAÚ : BBA S.A.",
              204 : "BANCO BRADESCO CARTÕES S.A.",
              208 : "BANCO UBS PACTUAL S.A.",
              212 : "BANCO MATONE S.A.",
              213 : "BANCO ARBI S.A.",
              214 : "BANCO DIBENS S.A.",
              215 : "BANCO ACOMERCIAL E DE INVESTIMENTO SUDAMERIS S.A.",
              217 : "BANCO JOHN DEERE S.A.",
              218 : "BANCO BONSUCESSO S.A.",
              222 : "BANCO CLAYON BRASIL S/A",
              224 : "BANCO FIBRA S.A.",
              225 : "BANCO BRASCAN S.A.",
              229 : "BANCO CRUZEIRO DO SUL S.A.",
              230 : "UNICARD BANCO MÚLTIPLO S.A.",
              233 : "BANCO GE CAPITAL S.A.",
              237 : "BANCO BRADESCO S.A.",
              241 : "BANCO CLASSICO S.A.",
              243 : "BANCO MAXIMA S.A.",
              246 : "BANCO ABC:BRASIL S.A.",
              248 : "BANCO BOAVISTA INTERATLANTICO S.A.",
              249 : "BANCO INVESTCRED UNIBANCO S.A.",
              250 : "BANCO SCHAHIN",
              252 : "BANCO FININVEST S.A.",
              254 : "PARANÁ BANCO S.A.",
              263 : "BANCO CACIQUE S.A.",
              265 : "BANCO FATOR S.A.",
              266 : "BANCO CEDULA S.A.",
              300 : "BANCO DE LA NACION ARGENTINA",
              318 : "BANCO BMG S.A.",
              320 : "BANCO INDUSTRIAL E COMERCIAL S.A.",
              341 : "BANCO ITAU S.A.",
              356 : "BANCO ABN AMRO REAL S.A.",
              366 : "BANCO SOCIETE GENERALE BRASIL S.A",
              370 : "BANCO WESTLB DO BRASIL S.A.",
              376 : "BANCO J.P. MORGAN S.A.",
              389 : "BANCO MERCANTIL DO BRASIL S.A.",
              394 : "BANCO BMC S.A.",
              399 : "HSBC BANK BRASIL S.A.",
              409 : "UNIBANCO ",
              412 : "BANCO CAPITAL S.A.",
              422 : "BANCO SAFRA S.A.",
              453 : "BANCO RURAL S.A.",
              456 : "BANCO DE TOKYO:MITSUBISHI UFJ BRASIL S.A.",
              464 : "BANCO SUMITOMO MITSUI BRASILEIRO S.A.",
              477 : "CITIBANK N.A.",
              479 : "BANCO ITAUBANK S.A.",
              487 : "DEUTSCHE BANK S. A.",
              488 : "JPMORGAN CHASE BANK, NATIONAL ASSOCIATION",
              492 : "ING BANK N.V.",
              494 : "BANCO DE LA REPUBLICA ORIENTAL DEL URUGUAY",
              495 : "BANCO DE LA PROVINCIA DE BUENOS AIRES",
              505 : "BANCO CREDIT SUISSE (BRASIL) S.A.",
              600 : "BANCO LUSO BRASILEIRO S.A.",
              604 : "BANCO INDUSTRIAL DO BRASIL S.A.",
              610 : "BANCO VR S.A.",
              611 : "BANCO PAULISTA S.A.",
              612 : "BANCO GUANABARA S.A.",
              613 : "BANCO PECUNIA S.A.",
              623 : "BANCO PANAMERICANO S.A.",
              626 : "BANCO FICSA S.A.",
              630 : "BANCO INTERCAP S.A.",
              633 : "BANCO RENDIMENTO S.A.",
              634 : "BANCO TRIANGULO S.A.",
              637 : "BANCO SOFISA S.A.",
              638 : "BANCO PROSPER S.A.",
              641 : "BANCO ALVORADA S.A",
              643 : "BANCO PINE S.A.",
              652 : "BANCO ITAÚ HOLDING FINANCEIRA S.A.",
              653 : "BANCO INDUSVAL S.A.",
              654 : "BANCO A.J. RENNER S.A.",
              655 : "BANCO VOTORANTIM S.A.",
              707 : "BANCO DAYCOVAL S.A.",
              719 : "BANIF : BANCO INTERNACIONAL DO FUNCHAL (BRASIL), S.A.",
              721 : "BANCO CREDIBEL S.A.",
              734 : "BANCO GERDAU S.A.",
              735 : "BANCO POTTENCIAL S.A.",
              738 : "BANCO MORADA S.A.",
              739 : "BANCO BGN S.A.",
              740 : "BANCO BARCLAYS S.A.",
              741 : "BANCO RIBEIRAO PRETO S.A.",
              743 : "BANCO SEMEAR S.A.",
              744 : "BANKBOSTON N.A.",
              745 : "BANCO CITIBANK S.A.",
              746 : "BANCO MODAL S.A.",
              747 : "BANCO RABOBANK INTERNATIONAL BRASIL S.A.",
              748 : "BANCO COOPERATIVO SICREDI S.A.",
              749 : "BANCO SIMPLES S.A.",
              751 : "DRESDNER BANK BRASIL S.A. BANCO MULTIPLO.",
              752 : "BANCO BNP PARIBAS BRASIL S.A.",
              753 : "BANCO COMERCIAL URUGUAI S.A.",
              756 : "BANCO COOPERATIVO DO BRASIL S.A. : BANCOOB",
              757 : "BANCO KEB DO BRASIL S.A."
]

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
            let cal: NSCalendar = NSCalendar.currentCalendar(){
                return cal.component(component, fromDate: self)
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