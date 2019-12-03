//
//  TabBarViewController.swift
//  Conviva
//
//  Created by Luma Gabino Vasconcelos on 02/12/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit



class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func unwindToTabBar(segue:UIStoryboardSegue) {
        
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title = "" {
            print("Oi")
        }
    }
}

