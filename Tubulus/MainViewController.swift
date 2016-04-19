//
//  MainViewController.swift
//  Tubulus
//
//  Created by Felipe Dias Pereira on 2016-04-19.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import DATAStack
import QRCodeReader
import AVFoundation
import Sync

class MainViewController: CoreDataTableViewController, FPHandlesMOC, QRCodeReaderViewControllerDelegate {
    
    private var dataStack:DATAStack!
    @IBOutlet weak var tableView: UITableView!
    lazy var carCodeCalc = BarCodeCalc()
    lazy var reader: QRCodeReaderViewController = {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeEAN13Code])
            builder.showTorchButton = true
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        self.coreDataTableView = self.tableView
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.alwaysBounceVertical = false
    }
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true, completion: {
            if result.metadataType == AVMetadataObjectTypeInterleaved2of5Code{
                //barcode
                do{
                    let barCodeStruct = try self.carCodeCalc.extractDataFromBarCode(result.value)
                    let json = barCodeStruct.toStringJSON().convertStringToDictionary()
                    let key = json["id"] as! String
                    let predicate = NSPredicate(format: "remoteID = %@", key)
                    Sync.changes([json], inEntityNamed: "Document", predicate: predicate, dataStack: self.dataStack, completion: { (error) -> Void in
                        if error != nil {
                            print(error)
                        }else{
                            
                        }
                    })
                }catch{
                    print(error)
                }
            }
        })
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        let document = self.fetchedResultsController!.objectAtIndexPath(indexPath) as! Document
        let cell = tableView.dequeueReusableCellWithIdentifier("BoletoCell")
        let day = document.expDate!.getComponent(.Day)
        let monthName = monthsName[document.expDate!.getComponent(.Month)!]
        cell?.textLabel?.text = "\(day!)/\(monthName!)"
        cell?.detailTextLabel?.text = document.value?.toMaskReais()
        return cell!
    }
    
    //MARK
    func receiveDataStack(incomingDataStack: DATAStack) {
        self.dataStack = incomingDataStack
    }

}