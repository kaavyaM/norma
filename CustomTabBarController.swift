//
//  CustomTabBarController.swift
//  Corgis
//
//  Created by Sal Valdes on 11/18/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup custom view controllers
        let normsController = NormTableViewController()
        let normsHomesNavController = UINavigationController(rootViewController: normsController)
        normsHomesNavController.tabBarItem.title = "Norms Home"
        
        viewControllers = [normsHomesNavController]
    }
}
