//
//  TTViewController.swift
//  Examples
//
//  Created by ENUUI on 2017/7/13.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit


class TTViewController: UIViewController {
   
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        lbl.backgroundColor = UIColor.brown
        lbl.text = "This is Top"
        scrollView.addSubview(lbl)
        scrollView.contentSize = CGSize(width: 0, height: 2000)
        
        scrollView.registerTTView(34)
        scrollView.ttView?.title = "网络连接失败..."
    }
    
    @IBAction func clickStart(_ sender: UIButton) {
        scrollView.openTT()
    }
    
    @IBAction func clickStop(_ sender: UIButton) {
        scrollView.closeTT()
    }

    
    deinit {
        print("deinit - TTViewController")
    }
}
