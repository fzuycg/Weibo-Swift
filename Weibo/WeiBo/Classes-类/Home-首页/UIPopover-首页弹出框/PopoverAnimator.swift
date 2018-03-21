//
//  PopoverAnimator.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/16.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    //对外暴露的属性
    var isPresented: Bool = false
    var presentedFrame: CGRect = CGRect.zero
    
    var callBack: ((_ isPresented: Bool) -> ())?
    
    // MARK:- 自定义构造函数
    //注意：如果自定义了一个构造函数，但是没有对默认的构造函数init()进行重写，那么自定义的构造函数将会覆盖默认的构造函数init()
    init(callBack: @escaping (_ isPresented: Bool) -> ()) {
        self.callBack = callBack
    }
}


// MARK:- 自定义转场代理的方法
extension PopoverAnimator: UIViewControllerTransitioningDelegate {
    // 改变弹出view的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = YCGPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentedFrame
        return presentation
    }
    
    //自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack!(isPresented)
        return self
    }
    
    //自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack!(isPresented)
        return self
    }
}

// MARK:- 弹出和消失动画的代理方法
extension PopoverAnimator:UIViewControllerAnimatedTransitioning {
    /// 动画执行的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 可以获取转场的上下文：可以通过转场上下文获取弹出的view和消失的view
    // UITransitionContextFromViewKey:获取消失的view
    // UITransitionContextToViewKey:获取弹出的view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissedView(transitionContext: transitionContext)
        
    }
    
    /// 自定义弹出动画
    private func animationForPresentedView (transitionContext: UIViewControllerContextTransitioning) {
        //1、获取弹出的view
        let presentedView = transitionContext.view(forKey:UITransitionContextViewKey.to)!
        
        //2、将弹出的view添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        
        //3、执行动画
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (_) in
            //必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    /// 自定义消失动画
    private func animationForDismissedView (transitionContext: UIViewControllerContextTransitioning) {
        //1、获取消失的view
        let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        //2、执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissedView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
        }) { (_) in
            dismissedView?.removeFromSuperview()
            //必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    
}
