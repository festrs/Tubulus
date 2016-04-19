//
//  TabBarController.swift
//  Tubulus
//
//  Created by Felipe Dias Pereira on 2016-04-19.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import DATAStack

class TabBarController: UITabBarController,FPHandlesMOC {

    func receiveDataStack(incomingDataStack: DATAStack) {
        for vc in self.viewControllers!{
            if let handler = vc as? FPHandlesMOC{
                handler.receiveDataStack(incomingDataStack)
            }
            
        }
    }
}
