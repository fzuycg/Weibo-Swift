//
//  CommentTitleButton.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/11/14.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class CommentTitleButton: UIButton {
    
    // MARK: -重写init()函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sizeToFit()
    }
    
    //swift规定，重写控件的init()或init(frame)方法，必须重写init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        imageView?.layer.cornerRadius = (imageView?.frame.size.width)!/2
        
        imageView?.frame.origin.x = 0
        titleLabel?.frame.origin.x = (imageView?.frame.size.width)! + 3
    }

}
