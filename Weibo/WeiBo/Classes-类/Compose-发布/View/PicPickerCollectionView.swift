//
//  PicPickerCollectionView.swift
//  WeiBo
//
//  Created by 杨春贵 on 2018/1/4.
//  Copyright © 2018年 杨春贵. All rights reserved.
//

import UIKit

private let picPickerCell = "picPickerCell"
private let picPickerItemCelledgeMargin: CGFloat = 10

class PicPickerCollectionView: UICollectionView {
    // MARK:- 定义属性
    var images: [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }

    // MARK:- 系统回调函数
    override func awakeFromNib() {
        //设置collectionView的layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemH = (kScreenWidth - 4*picPickerItemCelledgeMargin) / 3
        layout.itemSize = CGSize(width: itemH, height: itemH)
        layout.minimumInteritemSpacing = picPickerItemCelledgeMargin
        layout.minimumLineSpacing = picPickerItemCelledgeMargin
        
        //设置collectionView的内边距
        contentInset = UIEdgeInsetsMake(picPickerItemCelledgeMargin, picPickerItemCelledgeMargin, 0, picPickerItemCelledgeMargin)
        
        //注册cell
        register(UINib(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerCell)
        dataSource = self
    }

}

// MARK:- UICollectionViewDataSource
extension PicPickerCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCell, for: indexPath) as! PicPickerViewCell
        
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        
        return cell
    }
    
    
}
