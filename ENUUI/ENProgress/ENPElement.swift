//
//  ENProgressElement.swift
//  Example
//
//  Created by ENUUI on 2017/7/10.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit

public enum ENPAnimType {
    case `default`(Int)
    case scale(Int)
}

extension ENPAnimType {
    var keyPath: String {
        switch self {
        case .default:
            return "transform.rotation.z"
        case .scale:
            return "transform.scale"
        }
    }
    
    var anim: CABasicAnimation {
        let ani = CABasicAnimation(keyPath: self.keyPath)
        switch self {
        case .default:
            ani.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(2 * Double.pi), 0, 0, 1))
            ani.duration = 0.17
            ani.isCumulative = true
            ani.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        case .scale(let count):
            ani.fromValue = 1
            ani.toValue = 0.1
            ani.duration = 0.1 * CFTimeInterval(count)
            ani.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        }
        return ani
    }
}

public enum ENPTextType {
    case vertical
    case horizontal /// 水平
}

public protocol ENPElementPrtl {
    
    /// count of per circle. count must be > 0
    var count: Int { get }
    var size: CGSize? { get }
    var animSize: CGSize { get }
    
    /// size of per elemen
    var eleSize: CGSize { get }
    
    /// color of element
    var color: UIColor { get }
    
    var animType: ENPAnimType { get }
    
    var cornerRadius: CGFloat { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    
    /// set image for per element
    var elementImage: UIImage? { get }
    
    /// set elements
    var elementImages: [UIImage]? { get }
    
    /// animted image
    var image: UIImage? { get }
    
    var textType: ENPTextType { get }
    /// text to show whilt animtion
    var text: String { get }
    var textFont: UIFont { get }
    var textColor: UIColor { get }
    var textAttibute: NSAttributedString? { get }
    
    func repLayer() -> CAReplicatorLayer
    func ele() -> CALayer
    func anim() -> CABasicAnimation
}

public class ENPElement: ENPElementPrtl {
    
    fileprivate static let c: Int = 8
    
    public var count: Int = c
    public var size: CGSize?
    public var animSize: CGSize = CGSize(width: 30, height: 30)
    public var eleSize: CGSize = CGSize(width: 2.5, height: 8)
    public var color: UIColor = UIColor.white
    
    public var animType: ENPAnimType = ENPAnimType.default(c)
    
    public var cornerRadius: CGFloat = 0.0
    public var borderColor: UIColor = UIColor.gray
    public var borderWidth: CGFloat = 0.0
    
    public var elementImage: UIImage?
    public var elementImages: [UIImage]?
    
    public var image: UIImage?
    
    public var textType: ENPTextType =  ENPTextType.horizontal
    public var text: String = "马上就好"
    public var textFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightMedium)
    public var textColor: UIColor = UIColor.white
    public var textAttibute: NSAttributedString?
    
    public func repLayer() -> CAReplicatorLayer {
        let repLayer = CAReplicatorLayer()
        
        repLayer.frame = CGRect(x: 0, y: 0, width: self.animSize.width, height: self.animSize.height)
        guard self.image == nil else {
            return repLayer
        }
        
        let angle = CGFloat(Double.pi * 2.0 / Double(self.count))
        
        repLayer.instanceCount = self.count
        repLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        repLayer.instanceDelay = 0.1
        return repLayer
    }
    
    public func ele() -> CALayer {
        guard self.image == nil else {
            let iv = UIImageView(image: self.image)
            iv.frame = CGRect(x: 0, y: 0, width: self.animSize.width, height: self.animSize.height)
            return iv.layer
        }
        
        let x = (self.animSize.width - self.eleSize.width) * 0.5
        let lay = CALayer()
        lay.frame = CGRect(x: x, y: 0, width: self.eleSize.width, height: self.eleSize.height)
        
        lay.backgroundColor = self.color.cgColor
        lay.cornerRadius = self.cornerRadius
        lay.borderColor = self.borderColor.cgColor
        lay.borderWidth = self.borderWidth
        
        return lay
    }
    
    public func anim() -> CABasicAnimation{
        return self.animType.anim
    }
}
