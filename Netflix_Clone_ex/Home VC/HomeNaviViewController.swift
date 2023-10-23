//
//  HomeNaviViewController.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/19.
//

import UIKit

class HomeNaviViewController: UINavigationController {
    
    var effectViewAlpha: CGFloat = 0 {
        didSet {
            visuallEffectView.alpha = effectViewAlpha
        }
    }
    
    // 기본 뷰의 정보를 구하는 상수
    let statusBarHeight = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame.height ?? 0
    
    lazy private var visuallEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = self.navigationBar.bounds.insetBy(dx: 0, dy: -statusBarHeight).offsetBy(dx: 0, dy: -statusBarHeight)
        effectView.alpha = 0 
        return effectView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        
//        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        appearance.configureWithTransparentBackground()
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance
        
        let logo = UIImage(named: "netflix-icon")
        
        let logoButton = UIButton()
        logoButton.setImage(logo, for: .normal)
        logoButton.frame = CGRect(x: 20, y: 0, width: 34, height: 34)
//        logoButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        logoButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        visuallEffectView.alpha = 0.6
        
        self.navigationBar.addSubview(visuallEffectView)
        self.navigationBar.addSubview(logoButton)
        
//        self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: logoButton)
    }
    
}
