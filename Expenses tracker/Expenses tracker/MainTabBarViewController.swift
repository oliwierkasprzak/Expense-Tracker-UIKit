//
//  ViewController.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 06/12/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: CategoryViewController())
        let vc3 = UINavigationController(rootViewController: AddExpenseViewController())
        let vc4 = UINavigationController(rootViewController: ChartViewController())
        let vc5 = UINavigationController(rootViewController: ProfileViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "circle.grid.2x2")
        vc3.tabBarItem.image = UIImage(systemName: "plus.square.dashed")
        vc4.tabBarItem.image = UIImage(systemName: "chart.pie")
        vc5.tabBarItem.image = UIImage(systemName: "person")
        
        vc1.title = "Home"
        vc2.title = "Category"
        vc4.title = "Chart"
        vc5.title = "Profile"
        
        
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
    }


}

