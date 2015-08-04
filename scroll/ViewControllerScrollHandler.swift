//
//  ViewControllerScrollHandler.swift
//  scroll
//
//  Created by Andrew Breckenridge on 8/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        handleHeaderViewScroll(atOffset: scrollView.contentOffset.y)
    }
}

extension ViewController {
    private func handleHeaderViewScroll(atOffset offset: CGFloat) {
        var headerTransform = CATransform3DIdentity
        
        if offset < 0 { handlePullDown(&headerTransform, offset: offset)
        } else { handlePullUp(&headerTransform, offset: offset) }
        
        headerView.layer.transform = headerTransform
    }
    
    
    private func handlePullDown(inout headerTransform: CATransform3D, offset: CGFloat) {
        let headerScaleFactor = -offset / headerView.bounds.height
        let headerSizeVariation = ((headerView.bounds.height * (headerScaleFactor + CGFloat(1.0))) - headerView.bounds.height) / 2
        
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizeVariation, 0)
        headerTransform = CATransform3DScale(headerTransform, headerScaleFactor + 1, headerScaleFactor + 1, 0)
    }
    
    private func handlePullUp(inout headerTransform: CATransform3D, offset: CGFloat) {
        headerTransform = CATransform3DTranslate(headerTransform, 0, max(-StopTranslatingOffset, -offset), 0)
        
        let labelTransform = CATransform3DMakeTranslation(0, max(-FromBottomOffset, TouchesTopOffset), 0)
        
        lolImageBlurView.alpha = min(1, (offset - TouchesTopOffset) / FromBottomOffset)
    }
}