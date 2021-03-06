//
//  SettingsLauncher.swift
//  MyYoutube
//
//  Created by xszhao on 2016-09-02.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //why make this global? in order to use inside handleDismiss
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    let cellId = "StringId"
    
    //create black dimmer background view
    func showSettings() {
        //show menu
        //animate in
        if let window = UIApplication.sharedApplication().keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            //blackview covers collectionView, prevents collectionView from being clicked
            window.addSubview(blackView)
            window.addSubview(collectionView) //add collectionView
            
            let height: CGFloat = 200
            let y = window.frame.height - height
            
            //animate from bottom (window.frame.height) to top (200 pixels)
            collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            
            blackView.frame = window.frame
            //animation beginning state
            blackView.alpha = 0
            
            //smoother animation
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                    self.blackView.alpha = 1
                
                    self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, self.collectionView.frame.height)
                }, completion: nil)
            
            //dismiss view when tapped
            //add a gesture recognizer
        }
    }
    
    func handleDismiss() {
        UIView.animateWithDuration(0.5, animations: {
            self.blackView.alpha = 0
            //animate back
            if let window = UIApplication.sharedApplication().keyWindow {
                self.collectionView.frame = CGRectMake(0, window.frame.height, self.collectionView.frame.width, self.collectionView.frame.height)
            }
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //step 1: create a cell and populate it
        //step 2 returnthe cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, 50)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    override init() {
        super.init()
        
        //setup collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}