
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
    @IBOutlet weak var textView: UITextView!
    
    var realScrollView: UIScrollView?
    
    var contentSize: CGSize {
        get {
            let textViewFitSize = textView.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.max))
            let textViewInsetHeight = headerView.frame.height
            
            let textViewSize = CGSize(width: view.frame.width, height: textViewFitSize.height + textViewInsetHeight)
        
            return textViewSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = view as? UIScrollView {
            view.delegate = self
            view.contentSize = contentSize
        }
    }
    

    override func updateViewConstraints() {
        super.updateViewConstraints()
        view.layoutIfNeeded() // need to call this because that forces viewDidLayoutSubviews to get called twice, the second its called it has the right height
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame.size.width = view.frame.width
        textView.frame.size.width = view.frame.width
        
        textView.contentInset.top = headerView.frame.height
        textView.frame.size.height = contentSize.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("did appear")
        
        println("\(textView.frame.height) == \(textView.contentSize.height)")
        println((view as! UIScrollView).contentSize)
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

