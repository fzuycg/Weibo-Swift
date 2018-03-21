//
//  HomeViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/9.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
import SVProgressHUD

class HomeViewController: BaseViewController {
    // MARK:- 属性
    
    // MARK:- 懒加载属性
    private lazy var titleBtn: HomeTitleButton = HomeTitleButton()
    private lazy var popoverAnimator: PopoverAnimator = PopoverAnimator {[weak self] (isPresented) in
        self?.titleBtn.isSelected = isPresented
    }
    private lazy var statusesViewModelArray: [StatusesViewModel] = [StatusesViewModel]()
    private lazy var tipLabel: UILabel = UILabel()
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1、在没有登录的时候
        if !isLogin {
            return
        }
        
        // 2、设置导航栏内容
        setupNavigationBar()
        
        // 3、布局下拉刷新视图
        setupHeaderView()
        setupFooterView()
        
        // 4、设置提示标题
        setupTipLabel()
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    /// 设置Item和TitleView
    private func setupNavigationBar() {
        //1、设置导航栏左侧Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navBarItem_相机")
        
        //2、设置导航栏右侧Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navBarItem_扫一扫")
        
        //3、设置titleView
        let sreenName = UserAccountViewModel.shareIntance.account?.screen_name ?? ""
        titleBtn.setTitle(sreenName, for: .normal)
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
        //4、隐藏tableView自带的分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    /// 设置下拉刷新视图
    private func setupHeaderView() {
        //1、创建header
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewStatuses))
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("放开刷新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        
        //2、设置tableView的header
        tableView.mj_header = header
        
        //3、进入刷新状态
        tableView.mj_header.beginRefreshing()
        
        SVProgressHUD.show()
    }
    
    /// 设置上拉加载更多视图
    private func setupFooterView() {
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadMoreStatuses))
    }

    /// 设置提示label
    private func setupTipLabel() {
        //1、将tipLabel添加到父控件中 (此处有问题，没有添加到父视图的最下面，不知道原因,所以现在做动画效果就不是移动这个label，而是改变高度)
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
        
        //2、设置tipLabel的frame
        tipLabel.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)!, width: kScreenWidth, height: 0)
        
        //3、设置tipLabel的属性
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor  = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
    }
}

// MARK:- 按钮响应事件
extension HomeViewController {
    /// 标题按钮的响应事件
    @objc private func titleBtnClick(_ titleBtn: HomeTitleButton) {
        // 1、创建控制器
        let popoverVC = PopoverViewController()
        
        // 2、设置控制器的modal样式
        popoverVC.modalPresentationStyle = .custom
        
        // 3、设置转场的代理
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: (kScreenWidth-180)/2, y: 64, width: 180, height: 250)
        
        // 4、弹出控制器
        present(popoverVC, animated: true, completion: nil)
    }
    
    /// 转发按钮的点击事件
    @objc private func repostsBtnClick(_ repostsBtn: UIButton) {
        
    }
    
    /// 评论按钮的点击事件
    @objc private func commentsBtnClick(_ commentsBtn: UIButton) {
        let viewModel = statusesViewModelArray[commentsBtn.tag]
        
        let commentVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
        
        commentVC.viewModel = viewModel
        //隐藏tabBar
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(commentVC, animated: true)
        //这里设置显示tabBar，在返回的时候才能又显示出来
        self.hidesBottomBarWhenPushed = false
    }
    
    /// 点赞按钮的点击事件
    @objc private func attitudesBtnClick(_ attitudesBtn: UIButton) {
        
    }
    
}

// MARK:- 请求数据
extension HomeViewController {
    /// 加载最新数据
    @objc private func loadNewStatuses() {
        loadStatuses(isNewData: true)
    }
    
    /// 加载更多数据
    @objc private func loadMoreStatuses() {
        loadStatuses(isNewData: false)
    }
    
    /// 请求首页微博
    private func loadStatuses(isNewData: Bool) {
       //1、拿到since_id/max_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = statusesViewModelArray.first?.statuses?.mid ?? 0
        } else {
            max_id = statusesViewModelArray.last?.statuses?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        NetworkingTools.shareInstance.loadStatuses(since_id: since_id, max_id: max_id) { (result, error) in
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
            var tempViewModel = [StatusesViewModel]()
            for statusesDict in resultArray {
                let model = StatusesModel(dict: statusesDict)
                let viewModel = StatusesViewModel(statuses:model)
                tempViewModel.append(viewModel)
            }
            
            //4、将数据放入到成员变量的数组中
            if isNewData {
                self.statusesViewModelArray = tempViewModel + self.statusesViewModelArray
            } else {
                self.statusesViewModelArray += tempViewModel
            }
            
            //5、缓存图片
            self.cacheImage(viewModels: tempViewModel)
        }
    }
    
    /// 进行图片缓存
    private func cacheImage(viewModels: [StatusesViewModel]) {
        //1、创建group（写法在swift3.0之后有所不同）
        let group = DispatchGroup()
        
        //2、缓存图片
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                group.enter()
                SDWebImageManager.shared().loadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _, _, _) in
                    group.leave()
                })
            }
        }
        
        //3、刷新表格
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            
            SVProgressHUD.dismiss()
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            self.showTipLabel(count: viewModels.count)
        }
    }
    
    /// 显示提示Label
    private func showTipLabel(count: Int) {
        // 1、设置属性
        tipLabel.isHidden = false
        tipLabel.text = count == 0 ? "没有新微博" : "\(count)条新微博"
        
        // 2、执行动画
        UIView.animate(withDuration: 1.0, animations: {
            self.tipLabel.frame.size.height = 32
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
                self.tipLabel.frame.size.height = 0
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        }
    }
}

// MARK:- tableView的数据源方法&代理方法
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesViewModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1、创建cell
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")! as! HomeTableViewCell
        
        //2、给cell设置数据
        let viewModel = statusesViewModelArray[indexPath.row]
        cell.viewModel = viewModel
        
        //3、给cell按钮设置点击事件
        cell.repostsButton.tag = indexPath.row
        cell.repostsButton.addTarget(self, action: #selector(HomeViewController.repostsBtnClick(_:)), for: .touchUpInside)
        
        cell.commentsButton.tag = indexPath.row
        cell.commentsButton.addTarget(self, action: #selector(HomeViewController.commentsBtnClick(_:)), for: .touchUpInside)
        
        cell.attitudesButton.tag = indexPath.row
        cell.attitudesButton.addTarget(self, action: #selector(HomeViewController.attitudesBtnClick(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = statusesViewModelArray[indexPath.row]
        
        let StatuseDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "StatuseDetailsVC") as! StatuseDetailsViewController
        
        StatuseDetailsVC.id = (viewModel.statuses?.mid)!
        //隐藏tabBar
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(StatuseDetailsVC, animated: true)
        //这里设置显示tabBar，在返回的时候才能又显示出来
        self.hidesBottomBarWhenPushed = false
    }
    
}



