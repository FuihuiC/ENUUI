//
//  ENTTView.swift
//  ENUUI
//
//  Created by ENUUI on 2017/7/13.
//  Copyright © 2017年 fuhui. All rights reserved.
//

import UIKit
public typealias ENClosour = ()->Void

fileprivate let TTSCREEN_SIZE = UIScreen.main.bounds

public class ENTTView: UIView {
    
    convenience init(height: CGFloat) {
        let rect = CGRect(x: 0, y: -height, width: TTSCREEN_SIZE.width, height: height)
        self.init(frame: rect)
        
        setup()
    }
    
    fileprivate func setup() {
        self.addSubview(backgroudImageView)
        self.addSubview(titleLabel)
        self.addSubview(indicator)
        self.backgroundColor = UIColor.brown
    }
    
    var ttHeight: CGFloat {
        return self.frame.height
    }
    
    var backgroudImage: UIImage? {
        didSet {
            guard let img = backgroudImage else { return }
            backgroudImageView.image = img
            backgroudImageView.frame = self.bounds
            backgroudImageView.contentMode = .scaleAspectFill
        }
    }
    lazy var backgroudImageView = UIImageView()
    
    var title: String? {
        didSet {
            setupSubViews()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12.0)
        return lbl
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return ind
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(clickCancelBtn(sender:)), for: .touchUpInside)
        btn.setImage(UIImage.en_imageNamed("close"), for: .normal)
        return btn
    }()
    
    func clickCancelBtn(sender: UIButton) {
        clickCancel?()
    }
    
    func showCancel( _ clickCancel: ENClosour?) {
        showCancel = true
        
        cancelButton.frame = CGRect(x: TTSCREEN_SIZE.width - 40, y: 0.3 * ttHeight, width: 0.4 * ttHeight, height: 0.4 * ttHeight)
        self.addSubview(cancelButton)
        
        self.clickCancel = clickCancel
    }
    
    
    // MARK: - private
    fileprivate var clickCancel: ENClosour?
    fileprivate var showCancel: Bool = false
    fileprivate func setupSubViews() {
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        var maxX = TTSCREEN_SIZE.width * 0.8
        var lblMargin = TTSCREEN_SIZE.width * 0.2
        let titleLabelTextH = titleLabel.frame.height
        var lblW = titleLabel.frame.width
        
        if showCancel {
            maxX = cancelButton.frame.origin.x - 10.0
            lblMargin = TTSCREEN_SIZE.width - maxX
        }
        
        var lblX = lblMargin
        if lblW > TTSCREEN_SIZE.width - 2 * lblMargin {
            lblW = TTSCREEN_SIZE.width - 2 * lblMargin
        } else {
            lblX = (TTSCREEN_SIZE.width - lblW) * 0.5
        }
        
        titleLabel.frame = CGRect(x: lblX, y: 0, width: lblW, height: ttHeight)
        
        indicator.frame = CGRect(x: lblX - 10.0 - titleLabelTextH, y: (ttHeight - titleLabelTextH) * 0.5, width: titleLabelTextH, height: titleLabelTextH)
        indicator.startAnimating()
        
        cancelButton.frame = CGRect(origin: cancelButton.frame.origin, size: CGSize(width: titleLabelTextH, height: titleLabelTextH))
    }
}
