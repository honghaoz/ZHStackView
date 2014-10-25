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
    
    @IBOutlet weak var indexField: UITextField!
    @IBOutlet weak var newViewContainer: UIView!
    
    @IBOutlet weak var viewTop: UITextField!
    @IBOutlet weak var viewLeft: UITextField!
    @IBOutlet weak var viewBottom: UITextField!
    @IBOutlet weak var viewRight: UITextField!
    
    @IBOutlet weak var sampleViewsContainer: UIView!
    @IBOutlet weak var viewsTypeSeg: UISegmentedControl!
    
    var newView: UIView!
    var sampleViews = [UIView]()
    var containerInset = UIEdgeInsetsZero
    
    @IBOutlet weak var alignmentSeg: UISegmentedControl!
    
    @IBOutlet weak var presentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackedView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        alignmentSeg.selectedSegmentIndex = 0;
        self.alignmentSegChanged(alignmentSeg)
        
//        containerInset = UIEdgeInsetsMake(10, 20, 30, 20)
        stackedView.defaultSpacing = 0.0
        self.newViewInContainer()
        self.random(nil)
    }
    
    // MARK: - Actions
    
    @IBAction func random(sender: AnyObject!) {
        stackedView.reset()
        sampleViews = []
        
        for _ in 0 ..< Int(arc4random_uniform(UInt32(5))) {
            sampleViews.append(self.newRandomView())
        }
        sampleViews.append(self.newRandomView())
        
        stackedView.setUpViews(sampleViews, viewInsets: nil, containerInset: containerInset)
        centerStackView()
    }
    
    @IBAction func refresh(sender: AnyObject) {
        newView.removeFromSuperview()
        self.newViewInContainer()
    }
    
    @IBAction func append(sender: AnyObject) {
        stackedView.append(newView, viewInset: getViewInset())
        newViewInContainer()
        centerStackView()
    }
    
    @IBAction func insert(sender: AnyObject) {
        let index: Int = indexField.text.toInt()!
        stackedView.insert(newView, viewInset: getViewInset(), atIndex: index)
        newViewInContainer()
        centerStackView()
    }

    @IBAction func remove(sender: AnyObject) {
        let index: Int = indexField.text.toInt()!
        stackedView.removeAtIndex(index)
        centerStackView()
    }
    
    @IBAction func alignmentSegChanged(sender: AnyObject) {
        switch alignmentSeg.selectedSegmentIndex {
        case 0:
            stackedView.alignment = .Left
        case 1:
            stackedView.alignment = .Center
        case 2:
            stackedView.alignment = .Right
        default:
            stackedView.alignment = .Center
        }
        stackedView.relayoutAllViews(animated: true)
    }
    
    func newViewInContainer() {
        newView = newRandomView()
        
        newView.frame = CGRectMake((newViewContainer.bounds.size.width - newView.bounds.size.width) / 2.0, (newViewContainer.bounds.size.height - newView.bounds.size.height) / 2.0, newView.bounds.size.width, newView.bounds.size.height)
        newViewContainer.addSubview(newView)
    }
    
    func newRandomView() -> UIView {
        var newView = UIView(frame: CGRectMake(0, 0, CGFloat(arc4random_uniform(UInt32(newViewContainer.bounds.size.width))), CGFloat(arc4random_uniform(UInt32(newViewContainer.bounds.size.height)))))
        newView.backgroundColor = randomColor()
        return newView
    }
    
    func centerStackView() {
        self.presentView.addSubview(stackedView)
        stackedView.frame = CGRectMake((self.presentView.bounds.size.width - stackedView.bounds.size.width) / 2.0, 10, stackedView.bounds.size.width, stackedView.bounds.size.height)
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        indexField.resignFirstResponder()
        viewTop.resignFirstResponder()
        viewLeft.resignFirstResponder()
        viewBottom.resignFirstResponder()
        viewRight.resignFirstResponder()
    }
    
    func getViewInset() -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(viewTop.text.toInt()!), CGFloat(viewLeft.text.toInt()!), CGFloat(viewBottom.text.toInt()!), CGFloat(viewRight.text.toInt()!))
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

func randomColor() -> UIColor {
    return UIColor(red: random(255) / 255.0, green: random(255) / 225.0, blue: random(255) / 255.0, alpha: 0.9)
}

