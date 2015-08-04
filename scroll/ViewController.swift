
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
    
    @IBOutlet weak var changeColorButton: UIButton!
    
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
        
        changeColorButton.userInteractionEnabled = true
        
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

extension ViewController {
    
    @IBAction func buttonWasHit() {
        if headerView.backgroundColor == UIColor(red:0.917, green:0.286, blue:0.498, alpha:1) {
            headerView.backgroundColor = UIColor(red:0.319, green:0.371, blue:0.442, alpha:1)
        } else {
            headerView.backgroundColor = UIColor(red:0.917, green:0.286, blue:0.498, alpha:1)
        }
    }
}
