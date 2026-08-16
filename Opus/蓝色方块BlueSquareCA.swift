//
//  蓝色方块BlueSquareCA.swift
//  Opus
//
//  Created by Ar2c on 2026/07/21.
//

import UIKit

class BlueSquareCA: UIViewController {

    private let squareLayer = CALayer()
    private var tapFlag: Bool = false
    let container = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let length: Int = 100
        let (x,y) = centerOrigin(forRectWidth: CGFloat(length), height: CGFloat(length), inContainer: view.bounds.size)
        
        // 把container定位在屏幕中间
        container.frame = CGRect(x: x, y: y, width: length, height: length)
        view.addSubview(container)

        // layer的坐标是相对于container的：（0，0）
        squareLayer.frame = container.bounds
        squareLayer.backgroundColor = UIColor.systemBlue.cgColor
        // 把layer放到container里
        container.layer.addSublayer(squareLayer)

        let tap = UITapGestureRecognizer(target: self, action: #selector(squareTapped))
        container.addGestureRecognizer(tap)
    }
    
    @objc func squareTapped() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = tapFlag ? 2 : 1
        animation.toValue = tapFlag ? 1 : 2
        animation.duration = 0.5
        // 不过，我们自己绘制的动画不支持打断，所以中途再tap一下会导致跳变
        squareLayer.add(animation, forKey: "scale")
        // Todo：学习如何让自己绘制的CABasicAnimation支持打断？
        
        // CAlayer裸层自带一个（可打断的）隐式动画，关闭它。
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        // 更新 model 层的值
        // Layer接受的是3D变换。
        squareLayer.transform = CATransform3DMakeScale(tapFlag ? 1 : 2, tapFlag ? 1 : 2, 1)
        CATransaction.commit()
        
        tapFlag.toggle()
    }
    
    // 使得矩形对齐到父级的中心
    func centerOrigin(forRectWidth width: CGFloat, height: CGFloat, inContainer containerSize: CGSize) -> (Int, Int) {
        let x = (containerSize.width - width) / 2
        let y = (containerSize.height - height) / 2
        // 使用 round 四舍五入，避免 Int 直接截断造成 0.5 像素偏移
        return (Int(round(x)), Int(round(y)))
    }

}
