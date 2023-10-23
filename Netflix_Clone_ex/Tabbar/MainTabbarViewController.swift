//
//  MainTabbarViewController.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/18.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // home, new hot -> viewcontrollers
        
        // homeVC
//        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//
//        homeVC.tabBarItem.title = "HOME"
//        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        // home Navi VC
        let homeNaviVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNaviViewController") as! HomeNaviViewController
        homeNaviVC.tabBarItem.title = "HOME"
        homeNaviVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        
        // newhotVC
        let newhotVC = UIStoryboard(name: "NewHot", bundle: nil).instantiateViewController(withIdentifier: "NewHotViewController") as! NewHotViewController
        newhotVC.tabBarItem.title = "NEW & HOT"
        newhotVC.tabBarItem.image = UIImage(systemName: "party.popper.fill")
        
        let naviVC = UINavigationController(rootViewController: newhotVC)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        
        naviVC.navigationBar.standardAppearance = appearance
        naviVC.navigationBar.scrollEdgeAppearance = appearance
        naviVC.navigationBar.compactAppearance = appearance
        naviVC.navigationBar.compactScrollEdgeAppearance = appearance
        naviVC.navigationBar.topItem?.title = "NEW & HOT"
//        newhotVC.navigationItem.title = "NEW & HOT"
        
        self.viewControllers = [homeNaviVC, naviVC]
        
        
        let tabBarAppearance = UITabBarAppearance()
        // 스타일 적용
//        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        // 색깔 적용
        tabBarAppearance.backgroundColor = .black
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .gray
        tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.gray ]
        tabBarItemAppearance.selected.iconColor = .red
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor : UIColor.red ]
        
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }

}
