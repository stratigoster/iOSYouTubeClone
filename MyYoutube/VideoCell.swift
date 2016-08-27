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
                userProfileImageView.image = UIImage(named: profileImageName)
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
                })
                
            }).resume()
            print(thumbnailImageUrl)
        }
    }
    
    //must override this class
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blueColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tinderPhoto")
        imageView.contentMode = .ScaleAspectFill //now extending bounds
        imageView.clipsToBounds = true //have to solve it by this
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.greenColor()
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
        
        thumbnailImageView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        
        thumbnailImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 16).active = true
        thumbnailImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -16).active = true
        thumbnailImageView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 16).active = true
        thumbnailImageView.bottomAnchor.constraintEqualToAnchor(self.userProfileImageView.topAnchor, constant: -16).active = true
        
        separatorView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        separatorView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        //separatorView.topAnchor.constraintEqualToAnchor(thumbnailImageView.bottomAnchor, constant: 16).active = true
        separatorView.heightAnchor.constraintEqualToConstant(1).active = true
        //separatorView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
        userProfileImageView.leftAnchor.constraintEqualToAnchor(thumbnailImageView.leftAnchor).active = true
        userProfileImageView.widthAnchor.constraintEqualToConstant(44).active = true
        userProfileImageView.heightAnchor.constraintEqualToConstant(44).active = true
        userProfileImageView.bottomAnchor.constraintEqualToAnchor(separatorView.topAnchor, constant: -36).active = true
        
        titleLabel.rightAnchor.constraintEqualToAnchor(thumbnailImageView.rightAnchor).active = true
        titleLabel.leftAnchor.constraintEqualToAnchor(userProfileImageView.rightAnchor, constant: 12).active = true
        titleLabel.topAnchor.constraintEqualToAnchor(userProfileImageView.topAnchor).active = true
        //programmatic constraints do not work for constraint anchors
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
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

