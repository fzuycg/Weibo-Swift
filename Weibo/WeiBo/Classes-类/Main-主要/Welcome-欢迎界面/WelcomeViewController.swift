//
//  WelcomeViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/18.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    // MARK: 连线属性
    @IBOutlet weak var iconImageBottomCons: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!

    // MARK: 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置头像
        let profileUrl = UserAccountViewModel.shareIntance.account?.avatar_large
        //??：表示前面的可选类型有值，直接解包并直接赋值；如果前面的可选类型为空，直接使用后面的值
        let url = URL(string: profileUrl ?? "")
        iconImageView.sd_setImage(with: url!, placeholderImage: UIImage(named:"welcome_userIcon"))
        
        //1、改变约束大小
        iconImageBottomCons.constant = kScreenHeight - 230
        
        //2、执行动画
        //Damping:阻力系数越大，弹动的效果越不明显0～1
        //initialSpringVelocity:初始化速度
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name:"Main", bundle: nil).instantiateInitialViewController()!
        }
        
    }
}
