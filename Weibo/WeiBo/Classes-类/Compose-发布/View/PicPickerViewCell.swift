//
//  PicPickerViewCell.swift
//  WeiBo
//
//  Created by 杨春贵 on 2018/1/4.
//  Copyright © 2018年 杨春贵. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var addPicBtn: UIButton!
    @IBOutlet weak var delPicBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK:- 定义属性
    var image: UIImage? {
        didSet {
            if image != nil {
                imageView.image = image
                addPicBtn.isUserInteractionEnabled = false
                delPicBtn.isHidden = false
            } else {
                imageView.image = UIImage(named: "pic_picker_add")
                addPicBtn.isUserInteractionEnabled = true
                delPicBtn.isHidden = true
            }
        }
    }
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addPicBtn.addTarget(self, action: #selector(self.addPicBtnClick), for: .touchUpInside)
        delPicBtn.addTarget(self, action: #selector(self.delPicBtnClick), for: .touchUpInside)
    }

}

// MARK:- 响应事件
extension PicPickerViewCell {
    @objc private func addPicBtnClick() {
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
    }
    
    @objc private func delPicBtnClick() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickerDelPhotoNote), object: imageView.image)
    }
}


