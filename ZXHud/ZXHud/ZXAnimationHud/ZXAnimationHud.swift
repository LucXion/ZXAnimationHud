//
//  ZXAnimationHud.swift
//  ZXAnimationHud
//
//  Created by luc xion on 2021/4/2.
//

import Foundation
import UIKit

class ZXAnimationHud : UIView,ZXAnimationDrawAble{
    
    fileprivate lazy var circleGrayColor : UIColor = {
        return UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 250.0/255.0, alpha: 1);
    }()
    fileprivate lazy var circleGreenColor : UIColor = {
        return UIColor(red: 66/255.0, green: 213/255.0, blue: 81/255.0, alpha: 1);
    }()
    // 屏幕宽
    fileprivate lazy var screenWidth : CGFloat = {
        print("计算了多次screenWidth")
        return UIScreen.main.bounds.size.width;
    }()
    // 屏幕高
    fileprivate lazy var screenHeight : CGFloat = {
        print("计算了多次screenHeight")
        return UIScreen.main.bounds.size.height;
    }()
    
    fileprivate lazy var hudView : UIView = {
        
        let viewBack = UIView.init(frame: CGRect(x: screenWidth / 2 - 100, y: screenHeight / 2 - 164, width: 200, height: 125))
        viewBack.backgroundColor = .white
        viewBack.layer.cornerRadius = 5
        viewBack.layer.masksToBounds = true
        
        addSubview(viewBack)
        return viewBack
    }()
    fileprivate lazy var circleView : UIView = {
        
        // 添加加载中的提示框
        let circleView = UIView.init(frame: CGRect(x:200 / 2 - 25,y: 20, width:50, height:50))
        circleView.layer.cornerRadius = 25;
        
        hudView.addSubview(circleView)
        return circleView
    }()
    
    fileprivate lazy var contentLable : UILabel = {
        // 提示框内容
        let lable = UILabel.init(frame: CGRect(x: 0, y: 90, width: 200, height: 15))
        lable.text = ""
        lable.textColor = .black
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 14)
        
        hudView.addSubview(lable)
        return lable
    }()
}

/// 加载框
extension ZXAnimationHud {
    
    /// 隐藏提示框
    func hideView() {
        circleView.layer.removeAllAnimations()
        hudView.alpha = 0
    }
    
    /// 加载提示框
    /// - Parameter msg: <#msg description#>
    func showProgress(msg:String = "") {
        hideView()
        hudView.alpha = 1
        contentLable.text = msg
        
        // 添加一个静态的灰色圆环
        circleView.layer.addSublayer(creatCircleLayer(bounds: circleView.bounds,color:grayColor))
        
        // 添加一个绿色圆环
        let greenAnimationLayer = creatCircleLayer(bounds: circleView.bounds,color:greenColor);
        // 1.给绿色圆环添加strokeEnd动画
        let animationStorkeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animationStorkeEnd.fromValue = NSNumber.init(value: 0.0)
        animationStorkeEnd.toValue = NSNumber.init(value: 1.0)
        animationStorkeEnd.duration = 2
        animationStorkeEnd.repeatCount = 1000.0
        // 动画的模式：渐进渐出、匀速等
        let endTimingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0.80, 0.75, 1.00)
        animationStorkeEnd.timingFunction = endTimingFunction
        // 添加strokeEnd动画
        greenAnimationLayer.add(animationStorkeEnd, forKey: "strokeEnd")
        
        // 2.给绿色圆环添加strokeStart动画
        let animationStorkeStart = CABasicAnimation(keyPath: "strokeStart")
        animationStorkeStart.repeatCount = 1000.0;
        animationStorkeStart.fromValue =  NSNumber.init(value: 0.0)
        animationStorkeStart.toValue = NSNumber.init(value: 1.0)
        animationStorkeStart.duration = 2;
        
        let startAnimationTimingFunction = CAMediaTimingFunction(controlPoints: 0.65, 0.00, 1.00, 1.00)
        animationStorkeStart.timingFunction = startAnimationTimingFunction;
        greenAnimationLayer.add(animationStorkeStart, forKey: "strokeStart")
        
        circleView.layer.addSublayer(greenAnimationLayer)
    }
    
    
    /// 成功提示框
    /// - Parameter msg:
    func showSucceseProgress(msg:String = "") {
        hideView()
        hudView.alpha = 1
        contentLable.text = msg
        
        // 绘制默认圆环
        circleView.layer.addSublayer(creatCircleLayer(bounds: circleView.bounds,color:greenColor))
        
        // 绘制绿色圆环
        let greenLineLayer = CAShapeLayer()
        greenLineLayer.lineWidth = CGFloat(lineWidth);
        greenLineLayer.strokeColor = greenColor.cgColor;
        greenLineLayer.fillColor = UIColor.clear.cgColor;
        greenLineLayer.lineCap = kCALineCapRound
        
        // 创建✅的路线
        let SpathY = creatCircleBezierPath(bounds:circleView.bounds,startAngle: 67, endAndle: 202,clockwish:true);
        // 绘制对号第一笔
        SpathY.addLine(to: CGPoint(x: circleView.bounds.size.width * 0.42, y: circleView.bounds.size.width * 0.68))
        // 绘制对号第二笔
        SpathY.addLine(to: CGPoint(x: circleView.bounds.size.width * 0.77, y: circleView.bounds.size.width * 0.35))
        
        greenLineLayer.path = SpathY.cgPath;
        
        // 绘制✅动画
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = NSNumber.init(value: 0.0);
        endAnimation.toValue = NSNumber.init(value: 1.0);
        endAnimation.duration = 0.5;
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.duration = 0.4;
        startAnimation.beginTime = CACurrentMediaTime() + 0.2;
        startAnimation.fromValue = NSNumber.init(value: 0.0);
        startAnimation.toValue = NSNumber.init(value: 0.66);
        
        let startTimingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.6, 0.8, 1.1)
        startAnimation.timingFunction = startTimingFunction
        
        
        // 设置最终效果，防止动画结束之后效果改变
        greenLineLayer.strokeStart = 0.66;
        greenLineLayer.strokeEnd = 1.0;

        // 填充整个圆圈的线条
        greenLineLayer.add(endAnimation, forKey: "strokeEnd")
        greenLineLayer.add(startAnimation, forKey: "strokeStart")
//
        circleView.layer.addSublayer(greenLineLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute:
        {
            [weak self] in
            self?.hudView.alpha = 0;
        })
    }
    
    
    func showFailProgress(msg:String = "") {
        hideView()
        hudView.alpha = 1
        contentLable.text = msg
        
        // 绘制默认圆环
        circleView.layer.addSublayer(creatCircleLayer(bounds: circleView.bounds,color:redColor))
        
        // 两条线
        // 左边
        let leftLayer = CAShapeLayer()
        leftLayer.lineWidth = CGFloat(lineWidth);
        leftLayer.strokeColor = redColor.cgColor;
        leftLayer.fillColor = UIColor.clear.cgColor;
        leftLayer.lineCap = kCALineCapRound
        
        // 半圆+动画的绘制路径初始化
        let leftPath = UIBezierPath(arcCenter: CGPoint(x: circleView.bounds.size.width / 2, y: circleView.bounds.size.height / 2), radius: circleView.bounds.size.height / 2, startAngle: intToAngleFloat(-43), endAngle: intToAngleFloat(-315), clockwise: false);
        
        
        leftPath.addLine(to: CGPoint(x: circleView.bounds.size.width * 0.34, y: circleView.bounds.size.width * 0.33))
        
        // 把路径设置为当前图层的路径
        leftLayer.path = leftPath.cgPath
        
        circleView.layer.addSublayer(leftLayer)
        
        // 右边
        let rightLayer = CAShapeLayer();
        rightLayer.fillColor = UIColor.clear.cgColor
        rightLayer.lineCap = kCALineCapRound
        rightLayer.lineWidth = CGFloat(lineWidth)
        rightLayer.strokeColor = redColor.cgColor
        
        // 半圆+动画的绘制路径初始化
        let rightPath = UIBezierPath(arcCenter: CGPoint(x: circleView.bounds.size.width / 2, y: circleView.bounds.size.height / 2), radius: circleView.bounds.size.height / 2, startAngle: intToAngleFloat(-128), endAngle: intToAngleFloat(133), clockwise: true);
        
        rightPath.addLine(to: CGPoint(x: circleView.bounds.size.width * 0.66, y: circleView.bounds.size.width * 0.33))
        
        // 把路径设置为当前图层的路径
        rightLayer.path = rightPath.cgPath;
        
        circleView.layer.addSublayer(rightLayer)
        
        let timing = CAMediaTimingFunction.init(controlPoints: 0.3, 0.6, 0.8, 1.1)
        // 创建路径顺序绘制的动画
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.duration = 0.4;
        endAnimation.fromValue = NSNumber.init(value: 0.0);
        endAnimation.toValue = NSNumber.init(value: 1)
        // 创建路径顺序从结尾开始消失的动画
        let startAnimation = CABasicAnimation.init(keyPath: "strokeStart")
        startAnimation.duration = 0.4;// 动画使用时间
        startAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
        startAnimation.fromValue = NSNumber.init(value: 0.0);
        startAnimation.toValue = NSNumber.init(value: 0.84);
        
        startAnimation.timingFunction = timing;
        
        leftLayer.strokeStart = 0.84;//
        leftLayer.strokeEnd = 1.0;
        rightLayer.strokeStart = 0.84;//
        rightLayer.strokeEnd = 1.0;
        
        leftLayer.add(endAnimation, forKey: "strokeEnd");
        leftLayer.add(startAnimation, forKey: "strokeStart");
        rightLayer.add(endAnimation, forKey: "strokeEnd");
        rightLayer.add(startAnimation, forKey: "strokeStart");
    
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute:
        {
            [weak self] in
            self?.hudView.alpha = 0;
        })
    }
}

extension ZXAnimationHud {
    
    static var share : ZXAnimationHud = {
        () -> ZXAnimationHud in
        if (Static.instance == nil) {
            DispatchQueue.once {
                Static.instance = ZXAnimationHud()
                UIApplication.shared.keyWindow?.addSubview(Static.instance!)
            }
        }
        return Static.instance!;
    }();
}

fileprivate struct Static {
    static var instance: ZXAnimationHud?
}

fileprivate extension DispatchQueue {

    private static var _onceToken = [String]()
    
    class func once(token: String = "\(#file):\(#function):\(#line)", block: ()->Void) {
        // 上锁
        objc_sync_enter(self)
        defer
        {
            // 作用域结束后解锁 （不要做同步串行操作）
            objc_sync_exit(self)
        }
        // 同一行代码无论在哪个线程都只执行一次
        if _onceToken.contains(token)
        {
            return
        }
        _onceToken.append(token)
        block()
    }
}
