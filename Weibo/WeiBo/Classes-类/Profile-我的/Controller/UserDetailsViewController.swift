//
//  UserDetailsViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/12/5.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    // MARK:- 控件属性
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- 定义属性
    var uid: Int = 0
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.setContentOffset(CGPoint(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)!), animated: false)
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

}

// MARK:- 请求数据
extension UserDetailsViewController {
    /// 获取用户信息
    private func loadUserInfo() {
        let token = (UserAccountViewModel.shareIntance.account?.access_token)!
        
        NetworkingTools.shareInstance.loadUserInfo(access_token: token, uid: "\(uid)") { (result, error) in
            //1、错误校验
            if error != nil {
                print(error!)
                return
            }
            
            //2、拿到用户信息
            guard let userInfoDict = result else {
                return
            }
            
            let userModel = UserModel(dict: userInfoDict)
            userModel.description1 = userInfoDict["description"] as? String ?? ""
            
        }
    }
    
    /// 设置界面数据
    private func setupUIData(model: UserModel) {
        guard let urlString = model.profile_image_url else {
            return
        }
        guard let iconUrl = URL(string: urlString) else {
            return
        }
        
        
        self.tableView.reloadData()
    }
}
