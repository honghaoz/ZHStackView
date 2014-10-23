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
        
        var newView = UIView(frame: CGRectMake(0, 0, CGFloat(arc4random_uniform(UInt32(300))), CGFloat(arc4random_uniform(UInt32(100)))))
        newView.backgroundColor = UIColor.blueColor()
        stackedView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        sampleViews = [copyOfView(view1), copyOfView(view2), copyOfView(view3), copyOfView(view4), copyOfView(view5), newView]
        stackedView.setUpViews(sampleViews, viewInsets: nil, containerInset: UIEdgeInsetsMake(10, 20, 30, 20))
        
        alignmentSeg.selectedSegmentIndex = 1;
        self.alignmentSegChanged(alignmentSeg)
        
        stackedView.frame = CGRectMake((self.presentView.bounds.size.width - stackedView.bounds.size.width) / 2.0, 10, stackedView.bounds.size.width, stackedView.bounds.size.height)
        self.presentView.addSubview(stackedView)
    }
    
    // MARK: - Actions
    
    @IBAction func refreshViews(sender: AnyObject) {
        view1.backgroundColor = UIColor(red: random(255) / 255.0, green: random(255) / 225.0, blue: random(255) / 255.0, alpha: 0.9)
        view2.backgroundColor = UIColor(red: random(255) / 255.0, green: random(255) / 225.0, blue: random(255) / 255.0, alpha: 0.9)
        view5.backgroundColor = UIColor(red: random(255) / 255.0, green: random(255) / 225.0, blue: random(255) / 255.0, alpha: 0.9)
        sampleViews = [copyOfView(view1), copyOfView(view2), copyOfView(view3), copyOfView(view4), copyOfView(view5)]
        stackedView.setUpViews(sampleViews, viewInsets: nil, containerInset: UIEdgeInsetsMake(10, 5, 5, 5))
    }
    @IBAction func alignmentSegChanged(sender: AnyObject) {
        switch alignmentSeg.selectedSegmentIndex {
        case 0:
            stackedView.alignment = ZHViewAlignment.Left
        case 1:
            stackedView.alignment = ZHViewAlignment.Center
        case 2:
            stackedView.alignment = ZHViewAlignment.Right
        default:
            stackedView.alignment = ZHViewAlignment.Center
        }
        stackedView.relayoutAllViews(animated: true)
    }
}

// MARK: - Helpers
func copyOfView(view: UIView) -> UIView {
    var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(view)
    var copy: UIView = NSKeyedUnarchiver.unarchiveObjectWithData(data) as UIView
    return copy
}

func random(range: Int) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(range)))
}

