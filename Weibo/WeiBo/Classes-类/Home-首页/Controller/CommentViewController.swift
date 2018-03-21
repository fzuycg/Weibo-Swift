//
//  CommentViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/11/10.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    // MARK:- 属性
    var viewModel: StatusesViewModel?
    
    // MARK:- 懒加载属性
    private lazy var titleBtn: CommentTitleButton = CommentTitleButton()

    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1、设置导航栏
        setupNavigation()
    }
}

// MARK:- 设置UI界面
extension CommentViewController {
    /// 设置导航栏部分
    func setupNavigation() {
        //1、设置右侧Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "")
        
        //2、设置titleview
        let sreenName = viewModel?.statuses?.user?.screen_name ?? ""
        guard let userIconUrl = viewModel?.prifileUrl else{
            return
        }
        let imageView: UIImageView = UIImageView()
        imageView.setImageWith(userIconUrl, placeholderImage: UIImage(named: "welcome_userIcon"))
        
        titleBtn.setTitle(sreenName, for: .normal)
        titleBtn.setImage(imageView.image, for: .normal)
        titleBtn.addTarget(self, action: #selector(CommentViewController.titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
        //3、隐藏tabelview自带的线
        
    }
    
}

// MARK:- 按钮点击事件
extension CommentViewController {
    /// 标题按钮的点击事件
    @objc private func titleBtnClick(_ titleBtn: CommentTitleButton) {
        print("titleBtnClick")
    }
}

// MARK:- 数据请求
extension CommentViewController {
    /// 请求微博评论数据
    private func loadComment() {
        guard let viewModel = viewModel else { 
            return
        }
        
        NetworkingTools.shareInstance.loadComments(since_id: (viewModel.statuses?.mid)!) { (result, error) in
            //1、错误校验
            if error != nil {
                print(error!)
                return
            }
            
            //2、获取可选类型中的数据
//            guard let resultArray = result else {
//                return
//            }
        }
    }
}
