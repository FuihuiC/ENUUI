//
//  UIImage+ENUUI.swift
//  ENUUI
//
//  Created by ENUUI on 2017/7/14.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit

extension UIImage {
    public class func en_imageNamed(_ name: String) -> UIImage? {
        
        let bundle: NSString = "ENUUISource.bundle"
        if let img = UIImage(named: bundle.appendingPathComponent(name)) {return img }
        
        let fullBundle: NSString = "ENUUI/ENUUI.framework/ENUUISource.bundle"
        if let img = UIImage(named: fullBundle.appendingPathComponent(name)) { return img }
        
        return UIImage(named: name)
    }
}
