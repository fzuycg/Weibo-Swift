//
//  YCGPresentationController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/16.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class YCGPresentationController: UIPresentationController {
    var presentedFrame: CGRect = CGRect.zero
    
    private lazy var coverView: UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //1、设置弹出View的尺寸
        presentedView?.frame = presentedFrame
        
        //2、添加蒙版
        setupCoverView()
    }
}

// MARK:- 设置UI界面
extension YCGPresentationController {
    private func setupCoverView() {
        //1、添加蒙版(不能让蒙版挡住弹出框)
        containerView?.insertSubview(coverView, at: 0)
        
        //2、设置蒙版属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        //3、添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(YCGPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

// MARK:- 事件监听
extension YCGPresentationController {
    @objc private func coverViewClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
