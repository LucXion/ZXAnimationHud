//
//  ZXAnimationDrawTool.swift
//  ZXAnimationHud
//
//  Created by luc xion on 2021/4/3.
//

import Foundation
import UIKit

protocol ZXAnimationDrawAble where Self:ZXAnimationHud {
    /// 圆环线条宽度
    var lineWidth: Int { get }
    var grayColor : UIColor { get }
    var greenColor : UIColor { get }
    var redColor : UIColor { get }
}

extension ZXAnimationDrawAble {
    var lineWidth: Int {
        return 3
    }
    
    var grayColor : UIColor {
        return UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 250.0/255.0, alpha: 1);
    }
    
    var greenColor : UIColor {
        return UIColor(red: 66/255.0, green: 213/255.0, blue: 81/255.0, alpha: 1);
    }
    
    var redColor : UIColor {
        return UIColor.red;
    }
    
}

extension ZXAnimationDrawAble {
    
    /// 绘制一个指定颜色的圆环 CAShapeLayer
    /// - Parameters:
    ///   - bounds: bounds
    ///   - color: 圆环颜色
    /// - Returns:
    func creatCircleLayer(bounds:CGRect,color:UIColor) -> CAShapeLayer {
        // 绘制外部透明的圆形
        let circleBezier = initBezier(bounds: bounds, startAngle: 0, endAngle: 360, clokwise: false);
        
        // 创建外部透明圆形的图层
        let circleLayer = CAShapeLayer()
        circleLayer.path = circleBezier.cgPath;
        // 设置圆形的线宽
        circleLayer.lineWidth = CGFloat(lineWidth)
        // 绘制灰色圆圈
        circleLayer.strokeColor = color.cgColor
        // 填充颜色透明
        circleLayer.fillColor = UIColor.white.cgColor
        
        return circleLayer;
    }
    
    func creatCircleBezierPath(bounds:CGRect, startAngle:Int,endAndle:Int,clockwish:Bool) -> UIBezierPath {
        let bezier = UIBezierPath(arcCenter: CGPoint.init(x: bounds.size.width / 2, y: bounds.size.height / 2), radius: bounds.size.width / 2, startAngle: intToAngleFloat(startAngle), endAngle: intToAngleFloat(endAndle), clockwise: clockwish);
        return bezier;
    }
}

extension ZXAnimationDrawAble {
    func intToAngleFloat(_ angle:Int) -> CGFloat {
        return CGFloat(Double(angle)*(Double.pi)/180.0)
    }
    
    func initBezier(bounds:CGRect,startAngle:Int,endAngle:Int,clokwise:Bool) -> UIBezierPath {
        let circleBezier = UIBezierPath(arcCenter: CGPoint.init(x: bounds.size.width / 2, y: bounds.size.height / 2), radius: bounds.size.width / 2, startAngle: intToAngleFloat(startAngle), endAngle: intToAngleFloat(endAngle), clockwise:clokwise);
        return circleBezier;
    }
}
