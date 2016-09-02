//
//  SettingsLauncher.swift
//  MyYoutube
//
//  Created by xszhao on 2016-09-02.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    //why make this global? in order to use inside handleDismiss
    let blackView = UIView()
    
    //create black dimmer background view
    func showSettings() {
        //show menu
        //animate in
        
        if let window = UIApplication.sharedApplication().keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            //animation beginning state
            blackView.alpha = 0
            
            //animates in
            UIView.animateWithDuration(0.5, animations: {
                self.blackView.alpha = 1
            })
            
            //dismiss view when tapped
            //add a gesture recognizer
        }
    }
    
    func handleDismiss() {
        UIView.animateWithDuration(0.5, animations: {
            self.blackView.alpha = 0
        })
    }

    override init() {
        super.init()
    }
}