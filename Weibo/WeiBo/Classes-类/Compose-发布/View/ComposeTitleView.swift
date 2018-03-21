//
//  ComposeTitleView.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/24.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {
    // MARK:- 懒加载控件
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var screenNameLabel: UILabel = UILabel()
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面
extension ComposeTitleView {
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(-20) //？？？问题：这里没有顶部对齐，手动上移了20
        }
        screenNameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModel.shareIntance.account?.screen_name
    }
}
