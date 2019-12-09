//
//  TabBarViewController.swift
//  Conviva
//
//  Created by Luma Gabino Vasconcelos on 02/12/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var lastTabSelection: UITabBarItem?
    
    @IBAction func unwindToTabBar(segue:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }

    
}

extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Interesses" ||  item.title == "Perfil" {
            self.lastTabSelection = item
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let email = UserDefaults.standard.string(forKey: "Email")
        if (viewController is NavMyIniciativesViewController || viewController is NavProfileViewController) && email == "" {
            if let storyboard = self.storyboard {
                 let vc  = storyboard.instantiateViewController(identifier: "loginStoryboard")
                 self.present(vc, animated: true)
             }
            return false
        }
        return true
    }
}



