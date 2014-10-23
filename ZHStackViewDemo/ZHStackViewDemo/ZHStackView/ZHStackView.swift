//
//  ZHStackView.swift
//  ZHStackViewDemo
//
//  Created by Honghao Zhang on 2014-10-17.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit

class CellView: UIView {
    var view: UIView? = nil
    var inset: UIEdgeInsets = UIEdgeInsetsZero
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSException(name: "Invalid init", reason: "Dont use init(coder), use init(UIView, UIEdgeInsets?) instead", userInfo: nil).raise()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(view: UIView, inset: UIEdgeInsets? = nil) {
        super.init()
        self.bounds = view.bounds
        view.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)
        view.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.view = view
        self.addSubview(view)
        self.inset = inset == nil ? UIEdgeInsetsZero : inset!
    }
    
    func setTopInset(top: CGFloat) {
        self.inset = UIEdgeInsetsMake(top, self.inset.left, self.inset.bottom, self.inset.right)
    }
    func setLeftInset(left: CGFloat) {
        self.inset = UIEdgeInsetsMake(self.inset.top, left, self.inset.bottom, self.inset.right)
    }
    func setBottomInset(bottom: CGFloat) {
        self.inset = UIEdgeInsetsMake(self.inset.top, self.inset.left, bottom, self.inset.right)
    }
    func setRightInset(right: CGFloat) {
        self.inset = UIEdgeInsetsMake(self.inset.top, self.inset.left, self.inset.bottom, right)
    }
    
    func getWidth() -> CGFloat {
        return self.bounds.size.width + self.inset.left + self.inset.right
    }
}

enum ZHLayoutOrientation: Int {
    case Vertical
    case Horizontal
}

enum ZHViewAlignment: Int {
    case Left, Center, Right
}

class ZHStackView: UIView {
    
    private var width: CGFloat = 0.0
    private var height: CGFloat = 0.0
    
    var orientation: ZHLayoutOrientation = ZHLayoutOrientation.Vertical
    var alignment: ZHViewAlignment = ZHViewAlignment.Center
    var containerInset: UIEdgeInsets = UIEdgeInsetsZero
    var defaultSpacing: CGFloat = 5.0
    
    var rawViews: [UIView] = []
    var rawViewInsets: [UIEdgeInsets]?
    var cellViews: [CellView] = []
    
    // Property flag whether some subViews removed or new views added
    var viewsHaveChanges: (have: Bool, removes: [Int]?, adds: [Int]?) = (true, nil, nil)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSException(name: "Views count and insets count inconsistent", reason: "Count of views must equal to count of insets", userInfo: nil).raise()
    }
    
    override convenience init() {
        self.init(frame:CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews([])
    }
    
    convenience init(views: [UIView], viewInsets: [UIEdgeInsets]? = nil, containerInset: UIEdgeInsets? = UIEdgeInsetsZero) {
        self.init()
        self.setUpViews(views, viewInsets: viewInsets, containerInset: containerInset)
    }
    
    func setUpViews(views: [UIView], viewInsets: [UIEdgeInsets]? = nil, containerInset: UIEdgeInsets? = UIEdgeInsetsZero) {
        if views.count == 0 {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, containerInset!.left + containerInset!.right, containerInset!.top + containerInset!.bottom)
            return
        } else if let realInsets = viewInsets {
            // If insets is provided, count must equal to views.count
            if views.count != realInsets.count {
                NSException(name: "Views count and insets count inconsistent", reason: "Count of views must equal to count of insets", userInfo: nil).raise()
                return
            } else {
                self.rawViews = views
                self.rawViewInsets = realInsets
            }
        } else {
            self.rawViews = views
            self.rawViewInsets = nil
        }
        self.containerInset = containerInset!
        self.viewsHaveChanges = (true, nil, nil) // TODO: change
        self.relayoutAllViews(animated: false)
    }
    
    func reset() {
        self.width = 0.0
        self.height = 0.0
        for eachCell in self.cellViews {
            eachCell.view?.removeFromSuperview()
            eachCell.removeFromSuperview()
        }
        self.cellViews.removeAll(keepCapacity: false)
    }
    
    func relayoutAllViews(#animated: Bool) {
        if self.viewsHaveChanges.have {
            self.reset()
            
            if self.rawViewInsets != nil && self.rawViewInsets!.count != self.rawViews.count {
                NSException(name: "Views count and insets count inconsistent", reason: "Count of views must equal to count of insets", userInfo: nil).raise()
            }
            
            // Keep record max widths
            var maxLeftInset: CGFloat = self.containerInset.left
            var maxRightInset: CGFloat = self.containerInset.right
            var maxViewWidth: CGFloat = 0.0
            
            // Construt cellViews
            for index: Int in 0 ..< self.rawViews.count {
                var eachView: UIView = self.rawViews[index]
                var eachInset: UIEdgeInsets? = self.rawViewInsets?[index]
                if eachInset == nil {
                    eachInset = UIEdgeInsetsMake(self.defaultSpacing, 0, self.defaultSpacing, 0)
                }
                var newCellView = CellView(view: eachView, inset: eachInset)
                
                if maxLeftInset < newCellView.inset.left {maxLeftInset = newCellView.inset.left}
                if maxRightInset < newCellView.inset.right {maxRightInset = newCellView.inset.right}
                if maxViewWidth < newCellView.bounds.size.width {maxViewWidth = newCellView.bounds.size.width}
                
                self.cellViews.append(newCellView)
            }
            
            self.width = maxLeftInset + maxViewWidth + maxRightInset
        }
        
        var currentOriginY: CGFloat = self.containerInset.top
        
        UIView.animateWithDuration(0.5,
            animations: { () -> Void in
                // Layout cellViews
                for cellIndex: Int in 0 ..< self.cellViews.count {
                    var currentCell = self.cellViews[cellIndex]
                    
                    switch self.alignment {
                    case .Left:
                        // Align views to left
                        currentCell.frame = CGRectMake(max(currentCell.inset.left, self.containerInset.left), currentOriginY, currentCell.bounds.size.width, currentCell.bounds.size.height)
                    case .Center:
                        // Align views to center
                        currentCell.frame = CGRectMake((self.width - currentCell.bounds.size.width) / 2.0, currentOriginY, currentCell.bounds.size.width, currentCell.bounds.size.height)
                    case .Right:
                        // Align views to right
                        currentCell.frame = CGRectMake((self.width - max(currentCell.inset.right, self.containerInset.right) - currentCell.bounds.size.width), currentOriginY, currentCell.bounds.size.width, currentCell.bounds.size.height)
                    }
                    
                    self.addSubview(currentCell)
                    currentOriginY += currentCell.bounds.size.height
                    let nextIndex = cellIndex + 1
                    
                    // current cell view is not last one
                    if nextIndex < self.cellViews.count {
                        var nextCell = self.cellViews[nextIndex]
                        currentOriginY += max(currentCell.inset.bottom, nextCell.inset.top)
                    } else {
                        currentOriginY += self.containerInset.bottom
                    }
                }
                
                self.height = currentOriginY
                self.bounds = CGRectMake(0, 0, self.width, self.height)
        }, completion: nil)
        
        // Reset
        self.viewsHaveChanges = (false, nil, nil)
    }
}
