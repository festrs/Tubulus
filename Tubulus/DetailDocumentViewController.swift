//
//  DetailDocumentType1ViewController.swift
//  IBoleto-Project
//
//  Created by Felipe Dias Pereira on 2016-02-29.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class DetailDocumentViewController: UIViewController {
    
    @IBOutlet weak var expDateLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var barCodeImageView: UIImageView!
    @IBOutlet weak var barCodeLineLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var document: Document!
    
    //MARK: - APP Life
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        totalLabel.text = "\((document.value?.toMaskReais())!)"
        barCodeLineLabel.text = document.barCodeLine
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        self.expDateLabel.text = "\(dateFormatter.stringFromDate(document.expDate!))"
        let image = RSUnifiedCodeGenerator.shared.generateCode(document.remoteID!, machineReadableCodeObjectType: AVMetadataObjectTypeInterleaved2of5Code)
        barCodeImageView.image = image
        let monthName = monthsName[document.expDate!.getComponent(.Month)!]
        self.title = "\(document.expDate!.getComponent(.Day)!)/\(monthName!)"
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(DetailDocumentViewController.didClickBarCode(_:)))
        self.bankLabel.text = "\(self.document.bank!)"
        self.barCodeImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func didClickBarCodeLine(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = document.barCodeLine
        let screenSize: CGRect = self.view.bounds
        let point = CGPoint(x: self.view.center.x, y: screenSize.height-(74))
        self.view.makeToast("Número do boleto cópiado com sucesso", duration: 3.0, position: point)
    }
    
    func didClickBarCode(sender: UITapGestureRecognizer) {
        let screenSize: CGRect = self.view.bounds
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        backView.backgroundColor = .whiteColor()
        backView.contentMode = .ScaleAspectFit
        backView.userInteractionEnabled = true
        let imageView = self.barCodeImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        newImageView.frame = CGRectMake(0, 0, screenSize.width-(screenSize.width*0.25), screenSize.height-(screenSize.height*0.2))
        newImageView.center = CGPointMake(0,backView.center.y);
        backView.addSubview(newImageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailDocumentViewController.dismissFullscreenImage(_:)))
        backView.addGestureRecognizer(tap)
        
        let viewController = UIViewController()
        viewController.view.addSubview(backView)
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.CoverVertical
        viewController.modalTransitionStyle = modalStyle
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        //sender.view?.removeFromSuperview()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
