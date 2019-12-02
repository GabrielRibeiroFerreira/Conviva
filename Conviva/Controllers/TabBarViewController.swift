//
//  TabBarViewController.swift
//  Conviva
//
//  Created by Luma Gabino Vasconcelos on 02/12/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //Ainda não esta funcionando
    @IBSegueAction func profileSegue(_ coder: NSCoder) -> ProfileViewController? {
        let email = UserDefaults.standard.string(forKey: "Email")
        if email == "" {
            if let storyboard = self.storyboard {
                let vc  = storyboard.instantiateViewController(identifier: "loginStoryboard")
                self.present(vc, animated: true)
            }
        } else {
             return ProfileViewController(coder: coder)
        }
        return nil
    }
    
    
}
