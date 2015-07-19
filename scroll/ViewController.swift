
//
//  ViewController.swift
//  scroll
//
//  Created by Andrew Breckenridge on 7/19/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var realHeaderView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
    }
    

    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.layoutIfNeeded() // need to call this because that forces viewDidLayoutSubviews to get called twice, the second its called it has the right height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        println("did layout")
        
        textView.contentInset.top = headerView.frame.height
        headerViewWidth.constant = view.frame.width
        textViewHeight.constant = textView.contentSize.height + headerView.frame.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("did appear")
        
        realHeaderView = headerView
        headerView.removeFromSuperview()
        headerView = nil
        
        scrollView.addSubview(realHeaderView)
    }
}


// Plz ignore past this, this is just for scroll handling - I iz understanding everything past this point
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateViewForScroll()
        println("\(scrollView.contentOffset.y)")
    }
    
    private func updateViewForScroll() {
        
    }
}

