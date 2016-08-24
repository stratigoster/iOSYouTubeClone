//
//  ViewController.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-04.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

//videos 6:30 start to building out collectionViewController
//TODO use ios9 constraint anchors instead of VFL (cause it's too complicated to understand)
//TODO determine how to us programmatic size classes from german tutorials
//TODO upload a mock data (aka hardcoded data) app on the appstore that supports size classes rather than 
//rely on paying for backend.
//find and learn from the code from videos only.

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video] = {
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBloodVideo.thumbnailImageName = ""
        
        return [blankSpaceVideo]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        //please register the cell class without it you get the error
        //Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'attempt to register a cell class which is not a subclass of UICollectionViewCell (UICollectionView)'
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    func setupNavBarButtons() {
        //What's the difference between Template and original?
        let searchImage = UIImage(named: "search")?.imageWithRenderingMode(.AlwaysOriginal)
        //searchImage!.drawInRect(CGRectMake(0, 0, 48, 48))
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav")?.imageWithRenderingMode(.AlwaysOriginal)
        //moreImage!.drawInRect(CGRectMake(0, 0, 48, 48))
        
        let moreButton = UIBarButtonItem(image: moreImage, style: .Plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    func handleSearch() {
        print(123)
    }
    
    func handleMore() {
        print(123)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        menuBar.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        menuBar.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        menuBar.heightAnchor.constraintEqualToConstant(50).active = true
        menuBar.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! VideoCell
        
        //cell.video = videos[indexPath.item]
        
        return cell
    }
    
    //by default the size is 50 by 50, you change the size here
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //must keep ratio at 16:9 
        let height = (view.frame.width - 16 - 16) * 9/16
        return CGSizeMake(view.frame.width, height + 16 + 68 )
    }
    
    //by default the length is?
    //why do we need to set this to zero?
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

