
//
//  ViewController.swift
//  scroll
//
//  Created by Andrew Breckenridge on 7/19/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.contentInset.top = headerView.frame.height
        headerViewWidth.constant = view.frame.width
        println("didload")
        println("Basically here (or anywhere before the view is visible) I want to set the height of the textView to its contentHeight... That way the textView doesn't show  \(textView.contentSize)\n")
        
        textViewHeight.constant = 200
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("will appear")
        println("\(textView.contentSize.width) \(textView.contentSize.height)\n")

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        println("will layout")
        println("\(textView.contentSize.width) \(textView.contentSize.height)\n")

    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        println("updating view constraints")
        println("\(textView.contentSize.width) \(textView.contentSize.height)\n")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        println("did layout")
        println("\(textView.contentSize.width) \(textView.contentSize.height)")
        
        println("I assumed that in did layout subviews, the width of the view would be adjusted to the width of my screen.... But no \n")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("did appear")
        println("\(textView.contentSize.width) \(textView.contentSize.height)")
        println("only in the didappear does the width get adjusted to screensize and the height adjusted to the actual contentHeight")
        
        
        println("I suppose I could programatically set the textView width in didLoad, but I want to use the power of autolayout")
    }
}

