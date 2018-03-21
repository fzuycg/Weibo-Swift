//
//  MessageViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/9.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1、设置游客页面
        setupVisitorViewInfo()
        
        // 在没有登录的时候
        if !isLogin {
            return
        }
        //2、设置navigationbar
        setupNavigationBar()
    }

}

// MARK:- 设置UI界面
extension MessageViewController {
    /// 设置游客模式的页面信息
    private func setupVisitorViewInfo() {
        visitorView.setupVisitorViewInfo(imageName: "visitor_消息", tipText: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }
    
    /// 设置导航栏的内容
    private func setupNavigationBar() {
        //1、设置导航栏左侧Item
//        let leftBtn = UIBarButtonItem(title: "添加好友", style: .plain, target: self, action: #selector(ProfileViewController.addFriendeItemBtnClick))
//        //这里修改字体颜色/大小/字体
//        let attributes =  [NSAttributedStringKey.foregroundColor: UIColor.black,
//                           NSAttributedStringKey.font: UIFont(name: "Heiti SC", size: 17.0)!]
//        leftBtn.setTitleTextAttributes(attributes, for: .normal)
//        navigationItem.leftBarButtonItem = leftBtn
//
//        //2、设置导航栏右侧Item
//        let rightBtn = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(ProfileViewController.setupItemBtnClick))
//        rightBtn.setTitleTextAttributes(attributes, for: .normal)
//        navigationItem.rightBarButtonItem = rightBtn
        
        //3、隐藏tableView自带的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
}

// MARK:- tableView的数据源方法&代理方法
extension MessageViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1、创建cell
        let cell1: MessageTableViewCell1 = tableView.dequeueReusableCell(withIdentifier: "MessageCell1")! as! MessageTableViewCell1
        let cell2: MessageTableViewCell2 = tableView.dequeueReusableCell(withIdentifier: "MessageCell2")! as! MessageTableViewCell2
        
        //2、给cell设置数据
        if indexPath.row < 3 {
            switch indexPath.row {
            case 0:
                cell1.iconImageView?.image = UIImage(named: "message_cell_icon_我的")
                cell1.sreenNameLabel.text = "@我的"
            case 1:
                cell1.iconImageView?.image = UIImage(named: "message_cell_icon_评论")
                cell1.sreenNameLabel.text = "评论"
            default:
                cell1.iconImageView?.image = UIImage(named: "message_cell_icon_赞")
                cell1.sreenNameLabel.text = "赞"
            }
            return cell1
        }
        
        
        
        return cell2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select->\(indexPath.row)")
    }
    
}

