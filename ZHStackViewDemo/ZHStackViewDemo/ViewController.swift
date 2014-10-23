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
    
    @IBOutlet weak var sampleViewsContainer: UIView!
    @IBOutlet weak var viewsTypeSeg: UISegmentedControl!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIVisualEffectView!
    @IBOutlet weak var view4: UITextField!
    @IBOutlet weak var view5: UIView!
    
    var sampleViews = [UIView]()
    
    @IBOutlet weak var alignmentSeg: UISegmentedControl!
    
    @IBOutlet weak var presentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var randomViews: [UIView] = []
//        for i in 0 ..< 5 {
//            var newView = UIView(frame: CGRectMake(0, 0, CGFloat(arc4random_uniform(UInt32(100))), CGFloat(arc4random_uniform(UInt32(100)))))
//            newView.backgroundColor = UIColor.blueColor()
//            randomViews.append(newView)
//        }
        
        
        var newView = UIView(frame: CGRectMake(0, 0, CGFloat(arc4random_uniform(UInt32(300))), CGFloat(arc4random_uniform(UInt32(100)))))
        newView.backgroundColor = UIColor.blueColor()
        stackedView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        sampleViews = [copyOfView(view1), copyOfView(view2), copyOfView(view3), copyOfView(view4), copyOfView(view5), newView]
        stackedView.setUpViews(sampleViews, viewInsets: nil, containerInset: UIEdgeInsetsMake(10, 20, 30, 20))
        
        alignmentSeg.selectedSegmentIndex = 1;
        self.alignmentSegChanged(alignmentSeg)
        
        stackedView.frame = CGRectMake(50, 30, stackedView.bounds.size.width, stackedView.bounds.size.height)
        self.presentView.addSubview(stackedView)
    }
    
    // MARK: - Actions
    
    @IBAction func alignmentSegChanged(sender: AnyObject) {
        switch alignmentSeg.selectedSegmentIndex {
        case 0:
            stackedView.alignment = ZHStackView.ViewAlignment.Left
        case 1:
            stackedView.alignment = ZHStackView.ViewAlignment.Center
        case 2:
            stackedView.alignment = ZHStackView.ViewAlignment.Right
        default:
            stackedView.alignment = ZHStackView.ViewAlignment.Center
        }
        stackedView.relayoutAllViews()
    }
}

// MARK: - Helpers
func copyOfView(view: UIView) -> UIView {
    var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(view)
    var copy: UIView = NSKeyedUnarchiver.unarchiveObjectWithData(data) as UIView
    return copy
}

