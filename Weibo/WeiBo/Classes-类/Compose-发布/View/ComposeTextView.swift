//
//  ComposeTextView.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/12/27.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTextView: UITextView {
    //MARK:- 懒加载属性
    lazy var placeHolderLabel: UILabel = UILabel()

    //MARK:- 构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

}

// MARK:- 设置UI
extension ComposeTextView {
    ///
    private func setupUI() {
        addSubview(placeHolderLabel)
        // 设置frame
        placeHolderLabel.snp.makeConstraints({ (make) -> Void  in
            make.top.equalTo(8)
            make.left.equalTo(10)
        })
        
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事..."
        
        //设置内容的内边距
        textContainerInset = UIEdgeInsets(top: 8, left: 6, bottom: 0, right: 6)
    }
}
