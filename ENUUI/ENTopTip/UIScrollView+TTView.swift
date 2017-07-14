//
//  UIScrollView+TTView.swift
//  ENUUI
//
//  Created by ENUUI on 2017/7/14.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit

extension UIScrollView {
    /// the Top Tip container
    public var ttView: ENTTView? {
        get {
            return objc_getAssociatedObject(self, &ENUUITTViewKey.kENUUITTViewKey) as? ENTTView
        }
        set {
            objc_setAssociatedObject(self, &ENUUITTViewKey.kENUUITTViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func registerTTView(_ height: CGFloat = 44) {
        ttViewH = height
        _ = checkTTView()
    }
    
    public func openTT(_ cancelButton: ENClosour? = nil) {
        setTTViewShow(cancelButton)
    }
    
    public func closeTT() {
        setTTViewClose()
    }
}

extension UIScrollView {
    fileprivate struct ENUUITTViewKey {
        static var kENUUITTViewKey = "kENUUI_ttView_key"
        static var kENUUITTViewHeightKey = "kENUUI_ttView_height_key"
    }
    
    fileprivate var ttViewH: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &ENUUITTViewKey.kENUUITTViewHeightKey) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &ENUUITTViewKey.kENUUITTViewHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate func setTTViewShow(_ cancelButton: ENClosour?) {
        let ttview = checkTTView()
        self.addSubview(ttview)
        
        UIView.animate(withDuration: 0.25) {
            self.contentInset = UIEdgeInsetsMake(self.ttH(), 0, 0, 0)
        }
        
        if contentOffset.y < frame.height * 2.0 {
            setContentOffset(CGPoint(x: 0, y: -self.ttH()), animated: true)
        }
        
        ttview.showCancel {
            self.setTTViewClose()
            cancelButton?()
        }
    }
    
    fileprivate func setTTViewClose() {
        UIView.animate(withDuration: 0.25, animations: {
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }) { done in
            if let tt = self.ttView {
                tt.removeFromSuperview()
            }
        }
    }
    
    fileprivate func checkTTView() -> ENTTView {
        if let v = ttView { return v }
        let view = ENTTView(height: self.ttH())
        ttView = view
        return view
    }
    
    fileprivate func ttH() -> CGFloat {
        if let h = ttViewH {
            return h
        } else {
            return 44.0
        }
    }
}
