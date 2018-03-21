//
//  HomeTableViewCell.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/20.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin: CGFloat = 15
private let itemMargin: CGFloat = 6

class HomeTableViewCell: UITableViewCell {
    //MARK:- 界面约束属性
    @IBOutlet weak var contentLabelWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewEdgeBottomCons: NSLayoutConstraint!
    @IBOutlet weak var retweetedContentLabEdgeTopCons: NSLayoutConstraint!
    
    //MARK:- 控件属性
    @IBOutlet weak var iconImgVIew: UIImageView! //头像
    @IBOutlet weak var verifiedImgView: UIImageView! //等级
    @IBOutlet weak var sreenNameLabel: UILabel! //昵称
    @IBOutlet weak var vipImgView: UIImageView! //VIP图标
    @IBOutlet weak var timeLabel: UILabel! //时间
    @IBOutlet weak var sourceLabel: UILabel! //来源
    @IBOutlet weak var contentLabel: UILabel! //正文内容
    @IBOutlet weak var retweetedContentLabel: UILabel! //转发的微博正文
    @IBOutlet weak var retweetedBgView: UIView! //转发微博的背景view
    @IBOutlet weak var picCollectionView: PicCollectionView! //图片集合
    @IBOutlet weak var repostsButton: UIButton! //转发按钮
    @IBOutlet weak var commentsButton: UIButton! //评论按钮
    @IBOutlet weak var attitudesButton: UIButton! //点赞按钮
    
    //MARK:- 定义属性
    var viewModel: StatusesViewModel? {
        didSet {
            //1、nil值检验
            guard let viewModel = viewModel else {
                return
            }
            
            //2、设置属性
            //2.1、用户头像
            iconImgVIew.sd_setImage(with: viewModel.prifileUrl, placeholderImage: UIImage(named: "welcome_userIcon"))
            //2.2、认证图标
            verifiedImgView.image = viewModel.verifiedImage
            //2.3、昵称
            sreenNameLabel.text = viewModel.statuses?.user?.screen_name
            sreenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            //2.4、vip图标
            vipImgView.image = viewModel.vipImage
            //2.5、时间
            timeLabel.text = viewModel.creatAtText
            //2.6、来源
            sourceLabel.text = viewModel.sourceText
            //2.7、正文内容
            contentLabel.text = viewModel.statuses?.text
            
            //3、设置picView的宽高
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWidthCons.constant = picViewSize.width
            picViewHeightCons.constant = picViewSize.height
            
            //4、将picURLs传给 collectionView
            picCollectionView.picURLs = viewModel.picURLs
            
            //5、设置转发微博的正文
            if viewModel.statuses?.retweeted_status != nil {
                //5.1、设置正文
                if let screenName = viewModel.statuses?.retweeted_status?.user?.screen_name, let retweetedContent = viewModel.statuses?.retweeted_status?.text {
                    retweetedContentLabel.text = "@"+"\(screenName):"+retweetedContent
                }
                
                //5.2、显示背景
                retweetedBgView.isHidden = false
                
                //5.3、设置转发微博的正文到上面约束的值
                retweetedContentLabEdgeTopCons.constant = 15
                
            } else {
                //5.1、设置正文
                retweetedContentLabel.text = nil
                
                //5.2、隐藏背景
                retweetedBgView.isHidden = true
                
                retweetedContentLabEdgeTopCons.constant = 0
            }
            
            //6、设置微博转发/评论/点赞数
            repostsButton.setTitle(viewModel.repostsCountText, for: .normal)
            commentsButton.setTitle(viewModel.commentsCountText, for: .normal)
            attitudesButton.setTitle(viewModel.attitudesCountText, for: .normal)
            
        }
    }
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置微博正文的宽度
        contentLabelWidthCons.constant = kScreenWidth - 2*edgeMargin
    }

}


// MARK:- 计算方法
extension HomeTableViewCell {
    /// 计算picView的宽高
    private func calculatePicViewSize(count: Int) -> CGSize {
        //1、没有配图
        if count == 0 {
            picViewEdgeBottomCons.constant = 0
            return CGSize.zero
        }
        
        //有配图的时候需要这个约束有值
        picViewEdgeBottomCons.constant = 10
        
        //2、取出picView的layout进行设置
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = itemMargin
        layout.minimumInteritemSpacing = itemMargin //最小间距，小于就换行
        
        
        //3、单张配图
        if count == 1 {
            //3.1、取出图片
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: viewModel?.picURLs.last?.absoluteString)
            
            //3.2、设置一张图片时layout的itemSize
            layout.itemSize = CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
            
            return CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
        }
        
        //4、计算出一个item的宽高
        let itemWH = (kScreenWidth - 2 * edgeMargin - 2 * itemMargin) / 3
        
        //5、多张图片时layout的itemSize
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        //6、四张配图
        if count == 4 {
            let picViewWH = itemWH * 2 + itemMargin
            //这里宽度直接设置成picViewWH不会换行，所以加0.1（有待解决）
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        //7、其他数量配图
        //7.1、计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        //7.2、计算picView的宽高
        let picViewW = kScreenWidth - 2 * edgeMargin
        let picViewH = rows * itemWH + (rows - 1) * itemMargin
        return CGSize(width: picViewW, height: picViewH)
        
    }
}
