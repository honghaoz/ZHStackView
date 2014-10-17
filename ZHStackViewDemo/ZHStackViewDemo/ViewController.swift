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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

