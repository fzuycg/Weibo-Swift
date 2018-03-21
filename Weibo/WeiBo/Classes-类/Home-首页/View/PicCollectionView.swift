//
//  PicCollectionView.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/20.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SDWebImage

class PicCollectionView: UICollectionView {
    
    // MARK:- 定义属性
    var picURLs: [URL] = [URL]() {
        didSet {
            self.reloadData()
        }
    }
    
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        self.backgroundColor = UIColor.clear
    }
    
}

// MARK:- collectionView的数据源方法
extension PicCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1、获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PicCollectionViewCell
        
        //2、给cell设置数据
        cell.picURL = picURLs[indexPath.row]
        
        return cell
        
    }
}


// MARK:- 定义PicCollectionViewCell
class PicCollectionViewCell: UICollectionViewCell {
    // MARK:- 定义模型属性
    var picURL: URL? {
        didSet {
            guard let picURL = picURL else {
                return
            }
            picImageView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "正文占位图"))
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var picImageView: UIImageView!
    
}
