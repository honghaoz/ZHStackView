//
//  ViewController.swift
//  ZHStackViewDemo
//
//  Created by Honghao Zhang on 2014-10-17.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var stackedView: ZHStackView = ZHStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var randomViews: [UIView] = []
        for i in 0 ..< 5 {
            var newView = UIView(frame: CGRectMake(0, 0, CGFloat(arc4random_uniform(UInt32(100))), CGFloat(arc4random_uniform(UInt32(100)))))
            newView.backgroundColor = UIColor.blueColor()
            randomViews.append(newView)
        }
        stackedView.backgroundColor = UIColor.lightGrayColor()
        stackedView.setUpViews(randomViews, viewInsets: nil, containerInset: UIEdgeInsetsMake(10, 20, 30, 20))
        stackedView.frame = CGRectMake(200, 200, stackedView.bounds.size.width, stackedView.bounds.size.height)
        self.view.addSubview(stackedView)
        
//        
//        var scrollView: UIScrollView = UIScrollView(frame: CGRectMake(20, 150, 200, 200))
//        scrollView.backgroundColor = UIColor.redColor()
//        
//        var containerView: UIView = UIView()
//        containerView.backgroundColor = UIColor.yellowColor()
//        containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.view.addSubview(scrollView)
//        scrollView.addSubview(containerView)
//        
//        var height: NSLayoutConstraint = NSLayoutConstraint(
//            item: containerView,
//            attribute: NSLayoutAttribute.Height,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: containerView,
//            attribute: NSLayoutAttribute.Height,
//            multiplier: 0.0,
//            constant: 200.0)
//        
//        var width: NSLayoutConstraint = NSLayoutConstraint(
//            item: containerView,
//            attribute: NSLayoutAttribute.Width,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: containerView,
//            attribute: NSLayoutAttribute.Width,
//            multiplier: 0.0,
//            constant: 200.0)
//        
//        containerView.addConstraints([height, width])
//        
//        var top: NSLayoutConstraint = NSLayoutConstraint(
//            item: containerView,
//            attribute: NSLayoutAttribute.Top,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: scrollView,
//            attribute: NSLayoutAttribute.Top,
//            multiplier: 1.0,
//            constant: 0.0)
//        
//        var left: NSLayoutConstraint = NSLayoutConstraint(
//            item: containerView,
//            attribute: NSLayoutAttribute.Left,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: scrollView,
//            attribute: NSLayoutAttribute.Left,
//            multiplier: 1.0,
//            constant: 0.0)
//        
//        var bottom: NSLayoutConstraint = NSLayoutConstraint(
//            item: containerView,
//            attribute: NSLayoutAttribute.Bottom,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: scrollView,
//            attribute: NSLayoutAttribute.Bottom,
//            multiplier: 1.0,
//            constant: 0.0)
//        
//        var right: NSLayoutConstraint = NSLayoutConstraint(
//            item: containerView,
//            attribute: NSLayoutAttribute.Right,
//            relatedBy: NSLayoutRelation.Equal,
//            toItem: scrollView,
//            attribute: NSLayoutAttribute.Right,
//            multiplier: 1.0,
//            constant: 0.0)
//        
//        scrollView.addConstraints([top, left, bottom, right])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

