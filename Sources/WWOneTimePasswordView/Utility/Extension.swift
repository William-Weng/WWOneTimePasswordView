//
//  Extension.swift
//  WWOneTimePasswordView
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit

// MARK: - Collection (override function)
extension Collection {

    /// [為Array加上安全取值特性 => nil](https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings)
    subscript(safe index: Index) -> Element? { return indices.contains(index) ? self[index] : nil }
}

// MARK: - CALayer (function)
extension CALayer {
    
    /// 設定框線寬度
    /// - Parameter width: CGFloat
    /// - Returns: Self
    func _borderWidth(_ width: CGFloat) -> Self { self.borderWidth = width; return self }
    
    /// 設定框線顏色
    /// - Parameter color: UIColor
    /// - Returns: Self
    func _borderColor(_ color: UIColor) -> Self { self.borderColor = color.cgColor; return self }
    
    /// 設定圓角
    /// - Parameter color: UIColor
    /// - Returns: Self
    func _cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.masksToBounds = true
        self.cornerRadius = cornerRadius
        return self
    }
}

// MARK: - UIView (function)
extension UIView {
    
    /// 游標閃動效果 (全亮 100% => 全暗 0% / 一直閃)
    func _cursorBlinkAnimation() {
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.5
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        layer.add(animation, forKey: "cursorBlink")
    }
}
