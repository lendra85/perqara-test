//
//  AutoLayouts.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import UIKit
import Foundation

public protocol LayoutAnchor {
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}

public struct LayoutProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
}

public class LayoutProxy {
    public lazy var widthAnchor = property(with: view.widthAnchor)
    public lazy var heightAnchor = property(with: view.heightAnchor)
    public lazy var topAnchor = property(with: view.topAnchor)
    public lazy var bottomAnchor = property(with: view.bottomAnchor)
    public lazy var leftAnchor = property(with: view.leftAnchor)
    public lazy var rightAnchor = property(with: view.rightAnchor)
    public lazy var leadingAnchor = property(with: view.leadingAnchor)
    public lazy var trailingAnchor = property(with: view.trailingAnchor)
    public lazy var centerYAnchor = property(with: view.centerYAnchor)
    public lazy var centerXAnchor = property(with: view.centerXAnchor)

    private let view: UIView

    fileprivate init(view: UIView) {
        self.view = view
    }

    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor)
    }
}

public extension LayoutProperty {
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(equalTo: otherAnchor, constant: constant).isActive = true
    }

    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }

    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }
}

public extension UIView {
    func makeConstraint(using closure: (LayoutProxy) -> Void) {
        self.translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
    
    func centerXEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        self.makeConstraint { constraints in
            constraints.centerXAnchor == v.centerXAnchor + spacing
        }
    }
    
    func centerYEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        self.makeConstraint { constraints in
            constraints.centerYAnchor == v.centerYAnchor + spacing
        }
    }
    
    func centerXandYEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        self.centerXEdgeOf(v, by: spacing)
        self.centerYEdgeOf(v, by: spacing)
    }
    
    func setWidth(by width: CGFloat) {
        prepareViewLayout()
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(by height: CGFloat) {
        prepareViewLayout()
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat, andHeight: CGFloat) {
        prepareViewLayout()
        setWidth(by: width)
        setHeight(by: andHeight)
    }
    
    func updateHeightConstraint(by constant: CGFloat) {
        guard let constraint = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) else {
            setHeight(by: constant)
            return
        }
        
        constraint.constant = constant
    }
}

/// DSL operator to add constant to anchor
/// - Returns: Given anchor and constant
public func +<A: LayoutAnchor>(lhs: A, rhs: Spacing) -> (A, CGFloat) {
    return (lhs, rhs.rawValue)
}

public func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

/// DSL operator to subtract constant to anchor
/// - Returns: Given anchor and minus constant
public func -<A: LayoutAnchor>(lhs: A, rhs: Spacing) -> (A, CGFloat) {
    return (lhs, rhs.minus)
}

public func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

/// DSL operator to matching anchor by  equal with given constant: CGFloat
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

/// DSL operator to matching anchor by  equal with given constant: Spacing
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, Spacing)) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1.rawValue)
}

/// DSL operator to matching anchor by  equal
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.equal(to: rhs)
}

/// DSL operator to matching anchor by  greaterThanOrEqual with given constant: CGFloat
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

/// DSL operator to matching anchor by  greaterThanOrEqual with given constant
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, Spacing)) {
    lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1.rawValue)
}

/// DSL operator to matching anchor by  greaterThanOrEqual
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.greaterThanOrEqual(to: rhs)
}

/// DSL operator to matching anchor by  lessThanOrEqual with given constant: CGFloat
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

/// DSL operator to matching anchor by  lessThanOrEqual with given constant
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, Spacing)) {
    lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1.rawValue)
}

/// DSL operator to matching anchor by  lessThanOrEqual
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.lessThanOrEqual(to: rhs)
}


