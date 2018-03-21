//
//  MainViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/9.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    // MARK:- 懒加载属性
//    private lazy var composeBtn: UIButton = UIButton.creatButton(imageName: "compose", bgImageName: "composeBg")
    private lazy var composeBtn: UIButton = UIButton(imageName: "compose", bgImageName: "composeBg")
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComposeBtn()
    }
}

// MARK:- 设置UI界面
extension MainViewController {
    /// 设置发布按钮
    private func setupComposeBtn() {
        //1、添加到tabBar上
        tabBar.addSubview(composeBtn)
        
        //2、设置composeBtn的位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        //3、设置点击事件
        //Selector两种写法：1>Selector("composeBtnClick") 2>"composeBtnClick"
        //下面写法是对于@objc声明的方法的系统推荐写法（估计是最新版本swift）
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: .touchUpInside)
    }
}


// MARK:- 事件监听
extension MainViewController {
    // 事件监听的本质是发送消息，但是发送消息是OC的特性
    // 步骤：将方法包装@SEL --> 类中查找方法列表 --> 根据@SEL找到imp指针（函数指针）--> 执行函数
    // 如果在swift中函数声明为private，那么该方法不会添加到函数列表中
    // 如果在private前面加上@objc，那么该方法依然会添加到方法列表中
    @objc private func composeBtnClick(){
        let composeVC = ComposeViewController()
        
        let composeNav = UINavigationController(rootViewController: composeVC)
        
        present(composeNav, animated: true, completion: nil)
    }
    
}
