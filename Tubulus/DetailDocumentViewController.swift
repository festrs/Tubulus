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
    
    @IBOutlet weak var barCodeImageView: UIImageView!
    @IBOutlet weak var barCodeLineLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var document: Document!
    
    //MARK: - APP Life
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        totalLabel.text = document.value?.toMaskReais()
        barCodeLineLabel.text = document.barCodeLine
        let image = RSUnifiedCodeGenerator.shared.generateCode(document.remoteID!, machineReadableCodeObjectType: AVMetadataObjectTypeInterleaved2of5Code)
        barCodeImageView.image = image
        let monthName = monthsName[document.expDate!.getComponent(.Month)!]
        self.title = "\(document.expDate!.getComponent(.Day)!)/\(monthName!)"
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(DetailDocumentViewController.didClickBarCode(_:)))
        self.barCodeImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func didClickBarCodeLine(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = document.barCodeLine
        
        let point = CGPoint(x: self.view.center.x, y: 600)
        self.view.makeToast("Número do boleto cópiado com sucesso", duration: 3.0, position: point)
    }
    
    func didClickBarCode(sender: UITapGestureRecognizer) {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        backView.backgroundColor = .blackColor()
        backView.contentMode = .ScaleAspectFit
        backView.userInteractionEnabled = true
        let imageView = self.barCodeImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        newImageView.frame = CGRectMake(0, 0, screenSize.width-(screenSize.width*0.65), screenSize.height-(screenSize.height*0.2))
        //newImageView.center = CGPointMake(backView.center.x,backView.center.y);
        backView.addSubview(newImageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailDocumentViewController.dismissFullscreenImage(_:)))
        backView.addGestureRecognizer(tap)
        self.view.addSubview(backView)
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
