
//
//  ViewController.swift
//  scroll
//
//  Created by Andrew Breckenridge on 7/19/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let StopTranslatingOffset = CGFloat(122)
    let TouchesTopOffset = CGFloat(44)
    let FromBottomOffset = CGFloat(44)

    @IBOutlet weak var textViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textView: UITextView!
    let lolObjectHeight = CGFloat(4) // Thing you want to scale the size of
    let lolImageView = UIImageView() // Pattern ImageView
    
    lazy var lolImageBlurView: UIImageView = {
        let imageView = UIImageView(frame: self.headerView.frame)
        imageView.image = self.lolImageView.image
        imageView.contentMode = .ScaleAspectFill
        imageView.alpha = 0
        
        return imageView
    }()
    
    lazy var contentSize: CGSize = {
        let textViewFitSize = self.textView.sizeThatFits(CGSize(width: self.view.frame.width, height: CGFloat.max))
        let textViewInsetHeight = self.headerView.frame.height
        
        let textViewSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: textViewFitSize.height + textViewInsetHeight)
            
        return textViewSize
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = contentSize
        
        
        textViewWidthConstraint.constant = contentSize.width
        textViewHeightConstraint.constant = contentSize.height
      
        println(textView.frame.size)
    }
    

    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.layoutIfNeeded() // need to call this because that forces viewDidLayoutSubviews to get called twice, the second its called it has the right height
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        println(textView.frame.size)
        
        headerView.frame.size.width = contentSize.width
        textView.contentInset.top = headerView.frame.height
        
        scrollView.contentSize = contentSize
        textView.frame.size = contentSize
        
        println(textView.frame.size)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.frame.size = contentSize
         println(textView.frame.size)
    }
}


extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        var offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        println(offset)
        
        if offset < 0 {
            let headerScaleFactor = -offset / headerView.bounds.height
            let headerSizeVariation = ((headerView.bounds.height * (headerScaleFactor + CGFloat(1.0))) - headerView.bounds.height) / 2
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizeVariation, 0)
            headerTransform = CATransform3DScale(headerTransform, headerScaleFactor + 1, headerScaleFactor + 1, 0)
        }
        
        else {
            
            
            println("offset \(-StopTranslatingOffset) is \(max(-StopTranslatingOffset, -offset))")
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-StopTranslatingOffset, -offset), 0)
            // headerLabel.layer.transform = headerTransform
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-FromBottomOffset, TouchesTopOffset), 0)

            
            lolImageBlurView.alpha = min(1, (offset - TouchesTopOffset) / FromBottomOffset)

            
            let avatarScaleFactor = (min(StopTranslatingOffset, offset) / lolObjectHeight) / 1.4
            let avatarSizeVariation = ((lolObjectHeight * (avatarScaleFactor + 1)) - lolObjectHeight) / 2
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, avatarScaleFactor - 1, avatarScaleFactor - 1, 0)
            
            if offset <= StopTranslatingOffset {
//                if avatarImage.layer.zPosition < header.layer.zPosition{
//                    header.layer.zPosition = 0
//                }
            } else {
//                if avatarImage.layer.zPosition >= header.layer.zPosition{
//                    header.layer.zPosition = 2
//                }
            }
        }
        
        
        // avatarImage.layer.transform = avatarTransform
        headerView.layer.transform = headerTransform
    }
}

