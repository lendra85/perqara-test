//
//  Spacing.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import UIKit

public enum Spacing: CGFloat {
    case x0 = 0
    case x2 = 2.0
    case x4 = 4.0
    case x8 = 8.0
    case x12 = 12.0
    case x16 = 16.0
    case x20 = 20.0
    case x24 = 24.0
    case x32 = 32.0
    case x48 = 48.0
    case x64 = 64.0
    
    public var minus: CGFloat {
        self.rawValue * -1
    }
}

extension UIEdgeInsets {
    public init(top: Spacing, left: Spacing, bottom: Spacing, right: Spacing) {
        self.init(top: top.rawValue, left: left.rawValue, bottom: bottom.rawValue, right: right.rawValue)
    }
    
    public init(vertical: Spacing, left: Spacing, right: Spacing) {
        self.init(top: vertical.rawValue, left: left.rawValue, bottom: vertical.rawValue, right: right.rawValue)
    }
    
    public init(horizontal: Spacing, top: Spacing, bottom: Spacing) {
        self.init(top: top.rawValue, left: horizontal.rawValue, bottom: bottom.rawValue, right: horizontal.rawValue)
    }
    
    public init(vertical: Spacing, horizontal: Spacing) {
        self.init(top: vertical.rawValue, left: horizontal.rawValue, bottom: vertical.rawValue, right: horizontal.rawValue)
    }
}

public extension UIView {
    internal func prepareViewLayout() {
        guard self.translatesAutoresizingMaskIntoConstraints else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setX(_ x: CGFloat, andY y: CGFloat) {
        self.frame = CGRect(x: x, y: y, width: frame.size.width, height: frame.size.height)
    }
    
    func setX(_ x: Spacing) {
        self.setX(x.rawValue, andY: frame.origin.y)
    }

    func setY(_ y: Spacing) {
        self.setX(frame.origin.x, andY: y.rawValue)
    }
    
    func setX(_ x: Spacing, andY y: Spacing) {
        return setX(x.rawValue, andY: y.rawValue)
    }
    
    func insideEdgeOf(_ v: UIView, by spacing: UIEdgeInsets) {
        prepareViewLayout()
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: spacing.left),
            self.topAnchor.constraint(equalTo: v.topAnchor, constant: spacing.top),
            self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: spacing.right),
            self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: spacing.bottom),
        ])
    }

    func outsideEdgeOf(_ v: UIView, by spacing: UIEdgeInsets) {
        prepareViewLayout()
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: spacing.left),
            self.topAnchor.constraint(equalTo: v.topAnchor, constant: spacing.top),
            self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: spacing.right),
            self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: spacing.bottom),
        ])
    }
    
    func insideTopEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.topAnchor.constraint(equalTo: v.topAnchor, constant: spacing.minus).isActive = true
    }
        
    func insideLeftEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: spacing.minus).isActive = true
        self.leftAnchor.accessibilityActivate()
    }
    
    func insideBottomEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: spacing.minus).isActive = true
    }
    
    func insideRightEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: spacing.minus).isActive = true
    }
    
    func outsideTopEdge(of v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.topAnchor.constraint(equalTo: v.topAnchor, constant: spacing.rawValue).isActive = true
    }
    
    func outsideLeftEdge(of v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: spacing.rawValue).isActive = true
    }
    
    func outsideBottomEdge(of v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.topAnchor.constraint(equalTo: v.bottomAnchor, constant: spacing.rawValue).isActive = true
    }
    
    func outsideRightEdge(of v: UIView!, by spacing: Spacing = .x0) {
        prepareViewLayout()
        self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: spacing.rawValue).isActive = true
    }
    
    func rightToLeft(of v: UIView!, by spacing: Spacing = .x0, priority: UILayoutPriority? = nil) {
        prepareViewLayout()
        let constraint = self.rightAnchor.constraint(equalTo: v.leftAnchor, constant: spacing.rawValue)
        if let prio = priority {
            constraint.priority = prio
        }
        constraint.isActive = true
    }
    
    func rightToLeftGreater(of v: UIView!, by spacing: Spacing = .x0, priority: UILayoutPriority? = nil) {
        prepareViewLayout()
        let constraint = self.rightAnchor.constraint(greaterThanOrEqualTo: v.leftAnchor, constant: spacing.rawValue)
        if let prio = priority {
            constraint.priority = prio
        }
        constraint.isActive = true
    }
    
    func leftToRight(of v: UIView!, by spacing: Spacing = .x0, priority: UILayoutPriority? = nil) {
        prepareViewLayout()
        let constraint = self.leftAnchor.constraint(equalTo: v.rightAnchor, constant: spacing.rawValue)
        if let prio = priority {
            constraint.priority = prio
        }
        constraint.isActive = true
    }
    
    func topToBottom(of v: UIView!, by spacing: Spacing = .x0, priority: UILayoutPriority? = nil) {
        prepareViewLayout()
        let constraint = self.topAnchor.constraint(equalTo: v.bottomAnchor, constant: spacing.rawValue)
        if let prio = priority {
            constraint.priority = prio
        }
        constraint.isActive = true
    }
    
    func bottomToTop(of v: UIView!, by spacing: Spacing = .x0, priority: UILayoutPriority? = nil) {
        prepareViewLayout()
        let constraint = self.bottomAnchor.constraint(equalTo: v.topAnchor, constant: spacing.rawValue)
        if let prio = priority {
            constraint.priority = prio
        }
        constraint.isActive = true
    }
    
    func bottomToBottom(of v: UIView!, byGreaterThan spacing: Spacing = .x0, priority: UILayoutPriority? = nil) {
        prepareViewLayout()
        let constraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: v.bottomAnchor, constant: spacing.minus)
        if let prio = priority {
            constraint.priority = prio
        }
        constraint.isActive = true
    }
    
    func setHeight(_ height: Spacing = .x0) {
        setHeight(by: height.rawValue)
    }
    
    func setWidth(_ width: Spacing = .x0) {
        setWidth(by: width.rawValue)
    }
    
    func setWidth(_ width: Spacing = .x0, andHeight: Spacing = .x0) {
        prepareViewLayout()
        self.setWidth(width.rawValue, andHeight: andHeight.rawValue)
    }
}


