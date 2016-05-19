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
    lazy var alertHandler = AlertHandler.sharedInstance
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        self.configTableView()
    }
    
    func configTableView(){
        self.coreDataTableView = self.tableView
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.performFetch()
    }
    
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true, completion: {
            if result.metadataType == AVMetadataObjectTypeInterleaved2of5Code{
                //barcode
                do{
                    let barCodeStruct = try self.carCodeCalc.extractDataFromBarCode(result.value)
                    var json = barCodeStruct.toStringJSON().convertStringToDictionary()
                    let expDate = json["exp_date"] as? NSNumber
                    if (expDate == nil) {
                        DatePickerDialog().show("Data de Vencimento", doneButtonTitle: "Ok", cancelButtonTitle: "Cancelar", datePickerMode: .Date) {
                            (date) -> Void in
                            if date != nil{
                                let formatter = NSNumberFormatter()
                                formatter.minimumIntegerDigits = 2
                                let mes = "\(formatter.stringFromNumber((date!.getComponent(.Month))!)!)/\((date!.getComponent(.Year))!)"
                                json["exp_date"] = date
                                json["mes"] = mes
                                self.saveBarCodeObjectToCoreData(json)
                            }
                        }
                    }else{
                        self.saveBarCodeObjectToCoreData(json)
                    }
                }catch{
                    print(error)
                }
            }
        })
    }
    
    func saveBarCodeObjectToCoreData(jsonObject : [String:AnyObject]){
        let key = jsonObject["id"] as! String
        let predicate = NSPredicate(format: "remoteID = %@", key)
        Sync.changes([jsonObject], inEntityNamed: "Document", predicate: predicate, dataStack: self.dataStack, completion: { (error) -> Void in
            if error != nil {
                print(error)
            }else{
                self.performFetch()
                let items = self.fetchedResultsController?.fetchedObjects as! [Document]
                let doc = items.filter({$0.remoteID == key}).first
                self.alertHandler.createLocalNotification(doc!)
            }
        })
    }
    
    //MARK: - Actions
    @IBAction func editTapped(sender: AnyObject) {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
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
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: document.expDate!)
        let day = components.day
        let monthName = monthsName[document.expDate!.getComponent(.Month)!]
        cell?.textLabel?.text = "\(day)/\(monthName!)"
        cell?.detailTextLabel?.text = document.value?.toMaskReais()
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let document = self.fetchedResultsController!.objectAtIndexPath(indexPath) as! Document
            alertHandler.deleteLocalNotification(document)
            dataStack.mainContext.deleteObject(document)
            dataStack.persistWithCompletion(nil)
            self.performFetch()
            self.tableView.reloadData()
        }
    }
    
    //MARK
    func receiveDataStack(incomingDataStack: DATAStack) {
        self.dataStack = incomingDataStack
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailDocument"{
            if segue.destinationViewController.isKindOfClass(DetailDocumentViewController){
                let vc = segue.destinationViewController as! DetailDocumentViewController
                if sender!.isKindOfClass(UITableViewCell){
                    
                    if let cell = sender as? UITableViewCell,
                        indexPath = self.tableView.indexPathForCell(cell),
                        document = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? Document
                    {
                        vc.document = document
                    }
                }
            }
        }
    }
    
}
