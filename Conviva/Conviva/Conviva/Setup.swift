//
//  Setup.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 12/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation
import UIKit

class Setup {
    static func setupViewController(_ viewController : UIViewController){
        viewController.navigationController?.navigationBar.prefersLargeTitles = true
        viewController.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(named: "ConvivaOrange") ?? UIColor.orange,
            NSAttributedString.Key.font: UIFont(name: "Ubuntu-bold", size: 37)!]
        
        viewController.view.backgroundColor = UIColor(named: "ConvivaBackground")
    }
}
