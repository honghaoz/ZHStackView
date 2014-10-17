//
//  ZHStackView.swift
//  ZHStackViewDemo
//
//  Created by Honghao Zhang on 2014-10-17.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit

class CellView: UIView {
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

class ZHStackView: UIView {
    enum LayoutOrientation: Int {
        case Vertical
        case Horizontal
    }

    private var width: CGFloat = 0.0
    private var height: CGFloat = 0.0
    
    var orientation: LayoutOrientation = LayoutOrientation.Vertical
    var containerInset: UIEdgeInsets = UIEdgeInsetsZero
    var defaultSpacing: CGFloat = 5.0
    
    var rawViews: [UIView] = []
    var rawViewInsets: [UIEdgeInsets]?
    var cellViews: [CellView] = []
    
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
    
    init(views: [UIView], viewInsets: [UIEdgeInsets]? = nil, containerInset: UIEdgeInsets? = UIEdgeInsetsZero) {
        super.init()
        self.setUpViews(views, viewInsets: viewInsets, containerInset: containerInset)
    }
    
    func setUpViews(views: [UIView], viewInsets: [UIEdgeInsets]? = nil, containerInset: UIEdgeInsets? = UIEdgeInsetsZero) {
        if views.count == 0 {
            self.frame = CGRectZero
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
        self.relayoutAllViews()
    }
    
    // TODO: animated
    func relayoutAllViews() {
        self.width = 0.0
        self.height = 0.0
        self.cellViews.removeAll(keepCapacity: false)
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
        
        var currentOriginY: CGFloat = self.containerInset.top
        // Layout cellViews
        for cellIndex: Int in 0 ..< self.cellViews.count {
            var currentCell = self.cellViews[cellIndex]
            
            // Align views to left
            currentCell.frame = CGRectMake(max(currentCell.inset.left, self.containerInset.left), currentOriginY, currentCell.bounds.size.width, currentCell.bounds.size.height)
            
            // TODO:
            // Align views to center
            
            // Align views to right
            
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
    }
}
