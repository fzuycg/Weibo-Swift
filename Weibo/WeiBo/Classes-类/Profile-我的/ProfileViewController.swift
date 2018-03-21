//
//  ProfileViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/9.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusesCountLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var statusesButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    
    
    // MARK:- 定义属性
//    var viewModel: UserAccountViewModel? {
//        didSet {
//
//        }
//    }
    
    // MARK:- 数据属性
    var cellDataArray: [[(imageName: String, title: String, tip: String)]] = [[("priofile_cell_icon_1", "签到领红包", "百万现金天天领"), ("priofile_cell_icon_2", "我的好友", "")], [("priofile_cell_icon_3", "我的相册", ""), ("priofile_cell_icon_4", "我的赞", "收藏，移到这里了")], [("priofile_cell_icon_5", "微博红包", "测测你18年身价"), ("priofile_cell_icon_6", "微博运动", "每天一万步，与健康更亲近！"), ("priofile_cell_icon_7", "免流量", "5G流量，限量领")], [("priofile_cell_icon_8", "粉丝服务", "写文章、发点评、赚粉丝"), ("priofile_cell_icon_9", "粉丝头条", "推广博文及账号利器")], [("priofile_cell_icon_10", "客服中心", "")], [("priofile_cell_icon_11", "草稿箱", "")]]
    
    
    
    // MARK:- 系统回调函数
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
        
        //3、请求数据
        loadUserInfo()
    }
}

// MARK:- 设置UI界面
extension ProfileViewController {
    /// 设置游客模式的页面信息
    private func setupVisitorViewInfo() {
        visitorView.setupVisitorViewInfo(imageName: "visitor_我的", tipText: "登录后，你的微博、相册、个人资料在这里，展示给别人")
    }
    
    /// 设置导航栏的内容
    private func setupNavigationBar() {
        //1、设置导航栏左侧Item
        let leftBtn = UIBarButtonItem(title: "添加好友", style: .plain, target: self, action: #selector(ProfileViewController.addFriendeItemBtnClick))
        //这里修改字体颜色/大小/字体
        let attributes =  [NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font: UIFont(name: "Heiti SC", size: 17.0)!]
        leftBtn.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.leftBarButtonItem = leftBtn
        
        //2、设置导航栏右侧Item
        let rightBtn = UIBarButtonItem(title: "设置", style: .plain, target: self, action: #selector(ProfileViewController.setupItemBtnClick))
        rightBtn.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.rightBarButtonItem = rightBtn
        
        //3、隐藏tableView自带的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.statusesButton.addTarget(self, action: #selector(ProfileViewController.statusesBtnClick), for: .touchUpInside)
        self.friendsButton.addTarget(self, action: #selector(ProfileViewController.friendsBtnClick), for: .touchUpInside)
        self.followersButton.addTarget(self, action: #selector(ProfileViewController.followersBtnClick), for: .touchUpInside)
    }
    
}

// MARK:- 按钮响应事件
extension ProfileViewController {
    /// 添加好友按钮事件
    @objc private func addFriendeItemBtnClick() {
        print("addFriendeItemBtnClick")
    }
    
    /// 设置按钮事件
    @objc private func setupItemBtnClick() {
        print("setupItemBtnClick")
    }
    
    /// 微博数按钮事件
    @objc private func statusesBtnClick() {
        print("statusesBtnClick")
    }
    
    /// 关注数按钮事件
    @objc private func friendsBtnClick() {
        let friendsVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "FriendsListVC") as! FriendsListViewController
        
        //隐藏tabBar
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(friendsVC, animated: true)
        //这里设置显示tabBar，在返回的时候才能又显示出来
        self.hidesBottomBarWhenPushed = false
    }
    
    /// 粉丝数按钮事件
    @objc private func followersBtnClick() {
        print("followersBtnClick")
    }
}

// MARK:- tableView的数据源方法&代理方法
extension ProfileViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1、创建cell
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell")! as! ProfileTableViewCell
        
        //2、给cell设置数据
        cell.iconImageView.image = UIImage(named: cellDataArray[indexPath.section][indexPath.row].imageName)
        cell.titleLabel.text = cellDataArray[indexPath.section][indexPath.row].title
        cell.tipLabel.text = cellDataArray[indexPath.section][indexPath.row].tip
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    //返回分区头部高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select->\(indexPath.section).\(indexPath.row)")
    }
    
}

// MARK:- 请求数据
extension ProfileViewController {
    /// 获取用户信息
    private func loadUserInfo() {
        let token = (UserAccountViewModel.shareIntance.account?.access_token)!
        let uid = (UserAccountViewModel.shareIntance.account?.uid)!
        
        NetworkingTools.shareInstance.loadUserInfo(access_token: token, uid: uid) { (result, error) in
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
            
            self.setupUIData(model: userModel)
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
        self.iconImageView.setImageWith(iconUrl, placeholderImage: UIImage(named: "welcome_userIcon"))
        
        self.screenNameLabel.text = model.screen_name ?? ""
        
        var descriptionString = model.description1 ?? ""
        if descriptionString.count == 0 {
            descriptionString = "暂无简介"
        }
        self.descriptionLabel.text = "简介："+descriptionString
        
        self.statusesCountLabel.text = "\(model.statuses_count)"
        self.friendsCountLabel.text = "\(model.friends_count)"
        self.followersCountLabel.text = "\(model.followers_count)"
        
        self.tableView.reloadData()
    }
}


