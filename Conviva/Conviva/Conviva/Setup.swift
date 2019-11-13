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
    
    static func setupButton(_ button : UIButton){
        button.backgroundColor = UIColor(named: "ConvivaPink")
        button.setAttributedTitle(NSAttributedString(string: button.titleLabel?.text ?? "",
                                                    attributes: [NSAttributedString.Key.font: UIFont(name: "Ubuntu-bold", size: 18)
                                                                                            ?? UIFont.systemFont(ofSize: 18),
                                                                NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0)
//        button.frame.height = 55.0
        
    }
}
