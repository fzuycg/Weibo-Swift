//
//  FriendsListViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/12/4.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class FriendsListViewController: UIViewController {
    // MARK:- 控件属性
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- 懒加载属性
    private lazy var modelArray: [UserModel] = [UserModel]()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData(isNewData: true)
    }

}

// MARK:- 设置UI
extension FriendsListViewController {
    /// 设置界面
    private func setupUI() {
        self.title = "我的好友"
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
}

// MARK:- 按钮点击事件
extension FriendsListViewController {
    @objc private func followerBtnClick(_ followerBtn: UIButton) {
        
    }
}

// MARK:-UITableViewDelegate&&UITableViewDataSource
extension FriendsListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1、创建cell
        let cell: FriendsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell")! as! FriendsListTableViewCell
        
        //2、给cell设置数据
        let model: UserModel = modelArray[indexPath.row]
        cell.model = model
        
        //3、给cell按钮设置点击事件
        cell.followButton.tag = indexPath.row
        cell.followButton.addTarget(self, action: #selector(FriendsListViewController.followerBtnClick(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailsVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsViewController
        
        userDetailsVC.uid = self.modelArray[indexPath.row].id
        //隐藏tabBar
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }
    
}

// MARK:- 请求数据
extension FriendsListViewController {
    /// 请求数据
    private func loadData(isNewData: Bool) {
        guard let uidString = (UserAccountViewModel.shareIntance.account?.uid) else {
            return
        }
        let uid = Int("\(uidString)") ?? 0
        
        NetworkingTools.shareInstance.loadFrieds(uid: uid) { (result, error) in
            //1、错误校验
            if error != nil {
                print(error!)
                return
            }
            
            //2、获取可选类型中的数据
            guard let resultArray = result else {
                return
            }
            
            //3、遍历字典
//            var tempViewModel = [UserModel]()
            for userDict in resultArray {
                let model = UserModel(dict: userDict)
                model.description1 = userDict["description"] as? String
                self.modelArray.append(model)
            }
            
            //4、将数据放入到成员变量的数组中
//            if isNewData {
//                self.modelArray = tempViewModel + self.modelArray
//            } else {
//                self.modelArray += tempViewModel
//            }
            
            self.tableView.reloadData()
        }
    }
}
