//
//  ComposeViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/24.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    // MARK:- 懒加载属性
    private lazy var titleView: ComposeTitleView = ComposeTitleView()
    private lazy var images: [UIImage] = [UIImage]()
    
    // MARK:- 控件属性
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var picPickerBtn: UIButton!
    @IBOutlet weak var emojiBtn: UIButton!
    @IBOutlet weak var picPickerCollectionView: PicPickerCollectionView!
    
    // MARK:- 约束属性
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHCons: NSLayoutConstraint!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、设置导航栏
        setupNavigationBar()
        
        //监听通知
        setupNotification()
        
        picPickerBtn.addTarget(self, action: #selector(self.picPickerBtnClick), for: .touchUpInside)
        emojiBtn.addTarget(self, action: #selector(self.emojiBtnClick), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK:- 设置UI界面
extension ComposeViewController {
    /// 设置导航栏
    private func setupNavigationBar() {
        //1、设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(ComposeViewController.closeItemClick))
        
        //2、设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(ComposeViewController.sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        //3、设置标题
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        navigationItem.titleView = titleView
        
    }
    
    private func setupNotification() {
        //监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector:#selector(self.KeyboardWillChangeFrame(note:)),
                                               name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        //监听添加照片按钮的点击
        NotificationCenter.default.addObserver(self, selector: #selector(self.addPhotoBtnClick), name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
        //监听删除照片按钮的点击
        NotificationCenter.default.addObserver(self, selector: #selector(self.delPhotoBtnClick(note: )), name: NSNotification.Name(rawValue: PicPickerDelPhotoNote), object: nil)
    }
}

// MARK:- 事件监听
extension ComposeViewController {
    /// 关闭按钮点击事件
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 发送按钮点击事件
    @objc private func sendItemClick() {
        
    }
    
    /// 键盘弹出事件
    @objc private func KeyboardWillChangeFrame(note: Notification) {
        //1、获取动画执行时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        //2、获取键盘坐标
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = endFrame.origin.y
        
        //3、计算工具栏距离底部距离
        let margin = kScreenHeight - keyboardY
        
        //4、执行动画
        toolBarBottomCons.constant = margin
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// 照片按钮点击事件
    @objc private func picPickerBtnClick() {
        textView.resignFirstResponder()
        
        picPickerViewHCons.constant = kScreenHeight*0.65
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// 表情按钮点击事件
    @objc private func emojiBtnClick() {
        
    }
}

// MARK:- 添加与删除照片
extension ComposeViewController {
    @objc private func addPhotoBtnClick() {
        //1、判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("照片不可用！！！")
            return
        }
        //2、创建照片选择控制器
        let ipc = UIImagePickerController()
        
        //3、设置照片源
        ipc.sourceType = .photoLibrary
        
        //4、设置代理
        ipc.delegate = self
        
        //5、弹出控制器
        present(ipc, animated: true, completion: nil)
    }

    @objc private func delPhotoBtnClick(note: Notification) {
        //1、获取删除的照片
        guard let image = note.object as? UIImage else {
            return
        }
        
        //2、获取照片的下标值
        guard let index = images.index(of: image) else {
            return
        }
        
        //3、从数组中删除照片
        images.remove(at: index)
        
        //4、重新赋值
        picPickerCollectionView.images = images
    }
}

// MARK:- UIImagePickerControllerDelegate
extension ComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //1、获取选中的照片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //2、将照片添加到数组中
        images.append(image)
        
        //3、将数组赋值给collectioView，进行展示
        picPickerCollectionView.images = images
        
        //4、退出选择照片控制器
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK:- UITextViewDelegate
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}


