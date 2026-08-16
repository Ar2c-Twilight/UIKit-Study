//
//  ViewController.swift
//  Opus
//
//  Created by Ar2c on 2026/07/19.
//

import UIKit

class BlueSquare: UIViewController {

    let square = UIView()
    var tapFlag: Bool = false

    var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Blue Square"

        // 定义矩形
        let length: Int = 100
        let (x, y) = centerOrigin(
            forRectWidth: CGFloat(length), height: CGFloat(length), inContainer: view.bounds.size)
        square.frame = CGRect(x: x, y: y, width: length, height: length)
        square.backgroundColor = .systemBlue
        view.addSubview(square)

        // 定义tap手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(squareTapped))
        square.addGestureRecognizer(tap)

    }

    // 使得矩形对齐到父级的中心
    func centerOrigin(
        forRectWidth width: CGFloat, height: CGFloat, inContainer containerSize: CGSize
    ) -> (Int, Int) {
        let x = (containerSize.width - width) / 2
        let y = (containerSize.height - height) / 2
        // 使用 round 四舍五入，避免 Int 直接截断造成 0.5 像素偏移
        return (Int(round(x)), Int(round(y)))
    }

    @objc func squareTapped() {
        // if tapFlag {
        //     UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) {
        //         self.square.transform = CGAffineTransform(scaleX: 1, y: 1)
        //     }
        // } else {
        //     UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) {
        //         self.square.transform = CGAffineTransform(scaleX: 2, y: 2)
        //     }
        // }

        // 如果动画正在播放,直接反转方向,从当前视觉位置平滑倒放回去
        // if let animator = animator, animator.isRunning {
        //     animator.isReversed.toggle()
        //     return
        // }

        // tapFlag.toggle()
        let targetScale: CGFloat = tapFlag ? 1 : 2

        // UIViewPropertyAnimator 天生支持打断动画
        let newAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            // Affine(仿射)，就是2D的意思
            self.square.transform = CGAffineTransform(scaleX: targetScale, y: targetScale)
        }
        newAnimator.startAnimation()
        self.animator = newAnimator

        self.tapFlag = !tapFlag
    }
}
