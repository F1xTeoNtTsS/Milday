//
//  MiddleButton.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/19/21.
//

import UIKit

class MiddleButton: UIButton {
    
    
    func setupMiddleButton(view: UIView, tabbar: UITabBar) -> UIButton {
        let btn = UIButton(frame: CGRect(x: (Int(view.bounds.width) / 2) - 25 , y: -10, width: 60, height: 60))
        
        btn.setBackgroundImage(.add, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        tabbar.addSubview(btn)
        view.layoutIfNeeded()
        
        return btn
    }
    
    

}
