//
//  ProgressViewController.swift
//  Examples
//
//  Created by ENUUI on 2017/7/12.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit


class ProgressViewController: UIViewController {
    
   
    lazy var progress = ENPManager()
    
    @IBAction func clickType_2(_ sender: Any) {
        let ele = ENPElement()
        ele.image = UIImage.en_imageNamed("rotating")
        progress.start(ele, self.view)
    }
    
    @IBAction func clickType_1(_ sender: UIButton) {
        
        let ele = ENPElement()
        ele.eleSize = CGSize(width: 5.0, height: 5.0)
        ele.animType = ENPAnimType.scale(8)
        ele.count = 8
        ele.cornerRadius = 2.5
        ele.text = "xxxxxxxxxxxxxxxxxx"
        progress.start(ele, self.view)
    }
    
    @IBAction func clickStart(_ sender: UIButton) {
        progress.start(self.view)
    }
    
    @IBAction func clickStop(_ sender: UIButton) {
        progress.stop()
    }
}
