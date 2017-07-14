//
//  ENProgressManager.swift
//  ENProgress
//
//  Created by ENUUI on 2017/7/10.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit

public class ENPManager {
    
    typealias E = ENPElementPrtl
    
    func start(_ inView: UIView) {
        start(ENPElement(), inView)
    }
    
    func start<T: E>(_ element: T, _ inView: UIView) {
        
        for v in progressView.subviews {
            v.removeFromSuperview()
        }
        
        progressView.alpha = 1.0
        
        let lbl = text(element)
        
        let margin: CGFloat = 5.0
        let animVMaxY = element.animSize.height + margin
        var marginBetween:CGFloat = margin
        var size: CGSize {
            if element.size != nil  {
                marginBetween = element.size!.height - animVMaxY - margin - lbl.frame.height
                return element.size!
            } else {
                let w = lbl.frame.width / 0.8
                let h = animVMaxY + marginBetween + lbl.frame.height + margin
                return CGSize(width: w, height: h)
            }
        }
        
        lbl.frame = CGRect(x: size.width * 0.1,
                           y: animVMaxY + marginBetween,
                           width: size.width * 0.8,
                           height: lbl.frame.size.height)
        
        let animV = animView(element)
        animV.frame = CGRect(x: (size.width - element.animSize.width) * 0.5,
                             y: margin,
                             width: element.animSize.width,
                             height: element.animSize.height)
        
        
        progressView.frame = CGRect(origin: CGPoint(x: (inView.frame.width - size.width) * 0.5, y: (inView.frame.height - size.height) * 0.5), size: size)
        
        progressView.addSubview(lbl)
        progressView.addSubview(animV)
        inView.addSubview(progressView)
    }
    
    func stop(_ animted: Bool = true) {
        let anim = {
            self.progressView.alpha = 0.0
        }
        let completed = { (isDone: Bool) in
            self.progressView.removeFromSuperview()
        }
        if animted {
            UIView.animate(withDuration: 0.25, animations: anim, completion: completed)
        } else {
            completed(true)
        }
    }
    
    fileprivate lazy var progressView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 3.0
        v.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        return v
    }()
    
    fileprivate func animView<T: E>(_ element: T) -> UIView {
        
        let rep = element.repLayer()
        let el = element.ele()
        let an = element.anim()
        
        switch element.animType {
        case .default:
            rep.add(an, forKey: "")
        case .scale:
            el.add(an, forKey: "")
        }
        rep.addSublayer(el)
        
        let v = UIView()
        
        v.layer.addSublayer(rep)
        return v
    }
    
    fileprivate func text<T: E>(_ element: T) -> UILabel {
        let lbl = UILabel()
        if element.textAttibute != nil {
            lbl.attributedText = element.textAttibute
        } else {
            lbl.font = element.textFont
            lbl.textColor = element.textColor
            lbl.text = element.text
        }
        lbl.sizeToFit()
        return lbl
    }
}

