//
//  回调闭包.swift
//  Opus
//
//  Created by Ar2c on 2026/07/23.
//

import UIKit

class ClosureCallback: UIViewController {
    
    let button: UIButton = UIButton(type: .system)
    var closure: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let text:String = String(Int(view.bounds.width))
        
        view.backgroundColor = .systemBackground
            
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(text, for: .normal)
        button.frame = CGRect(x: 50, y: 100, width: 300, height: 50)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        button.isSelected = true
        closure?()
    }

}
