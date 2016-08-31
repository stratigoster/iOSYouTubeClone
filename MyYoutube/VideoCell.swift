//
//  VideoCell.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-22.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

//implement a custom cell in collectionViewController



class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var titleLabelHeightConstraint: NSLayoutConstraint?

class VideoCell: BaseCell {
    
    //willSet and didSet observers are not called when a property is first initialized. They are only called when the property’s value is set outside of an initialization context
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            if let profileImageName = video?.channel?.profileImageName {
                print(profileImageName)
                userProfileImageView.loadImageUsingUrlString(profileImageName)
            }
            
            if let channelName = video?.channel?.name, numberOfViews = video?.numberOfViews {
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                
                let subtitleText = "\(channelName) * \(numberFormatter.stringFromNumber(numberOfViews)!) * 2 years ago "
                subtitleTextView.text = subtitleText
            }
            
            //create a dynamic layout that expands when you have more text
            //measure title text so that it fits the screen correctly
            if let title = video?.title {
                //from left to right (distance + image + distance)
                let size = CGSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
                
                //estimate how much the title text is
                let estimatedRect = NSString(string: title).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    //support two rows of text
                    titleLabelHeightConstraint?.constant = 44
                }
                else {
                    //support one row of text
                    //titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            let url = NSURL(string: thumbnailImageUrl)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.thumbnailImageView.image = UIImage(data: data!)
                    //self.thumbnailImageView.image = UIImage(named: "tinderPhoto")
                    self.thumbnailImageView.image = self.ResizeImage( self.thumbnailImageView.image!, targetSize: CGSizeMake(self.frame.width - 32, 200.0))
                })
                
            }).resume()
        }
    }
    
    //must override this class
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit //now extending bounds
        //imageView.clipsToBounds = true //have to solve it by this
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "44x44")
        imageView.contentMode = .ScaleAspectFill //now extending bounds
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Taylor Swift - Blank Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,1604,684,607 views * 2 years"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0) //fixes issue of formatting
        textView.textColor = UIColor.lightGrayColor()
        return textView
    }()
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        thumbnailImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 16).active = true
        thumbnailImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -16).active = true
        thumbnailImageView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 8).active = true
        
        userProfileImageView.leftAnchor.constraintEqualToAnchor(thumbnailImageView.leftAnchor).active = true
        userProfileImageView.widthAnchor.constraintEqualToConstant(44).active = true
        userProfileImageView.heightAnchor.constraintEqualToConstant(44).active = true
        userProfileImageView.bottomAnchor.constraintEqualToAnchor(separatorView.topAnchor, constant: -36).active = true
        
        separatorView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        separatorView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        separatorView.topAnchor.constraintEqualToAnchor(self.userProfileImageView.bottomAnchor).active = true
        separatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        titleLabel.rightAnchor.constraintEqualToAnchor(thumbnailImageView.rightAnchor).active = true
        titleLabel.leftAnchor.constraintEqualToAnchor(userProfileImageView.rightAnchor, constant: 12).active = true
        titleLabel.topAnchor.constraintEqualToAnchor(userProfileImageView.topAnchor).active = true
        titleLabel.heightAnchor.constraintEqualToConstant(44).active = true
        //programmatic constraints do not work for constraint anchors
        
        //titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44)
        //addConstraint(titleLabelHeightConstraint!)
        //titleLabel.hei(titleLabelHeightConstraint).active = true
        
        subtitleTextView.leftAnchor.constraintEqualToAnchor(titleLabel.leftAnchor).active = true
        subtitleTextView.rightAnchor.constraintEqualToAnchor(titleLabel.rightAnchor).active = true
        subtitleTextView.heightAnchor.constraintEqualToConstant(30).active = true
        subtitleTextView.bottomAnchor.constraintEqualToAnchor(separatorView.topAnchor, constant: -4).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

