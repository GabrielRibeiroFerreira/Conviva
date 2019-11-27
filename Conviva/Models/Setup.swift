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
        viewController.navigationController?.navigationBar.backgroundColor = UIColor(named: "ConvivaBackground")
    }
    
    static func setupButton(_ button : UIButton, withText title : String){
        button.backgroundColor = UIColor(named: "ConvivaPink")
        button.setAttributedTitle(NSAttributedString(string: title,
                                                    attributes: [NSAttributedString.Key.font: UIFont(name: "Ubuntu-bold", size: 18)
                                                                                            ?? UIFont.systemFont(ofSize: 18),
                                                                NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 20.0, left: 40.0, bottom: 20.0, right: 40.0)
        button.frame = CGRect(x: button.frame.midX, y: button.frame.midY, width: button.frame.width, height: 60)
        button.layer.cornerRadius = button.frame.height/2
        
    }
    
    static func setupWeekday(_ weekday : Int) -> String{
        var day : String
        
        switch weekday {
        case 1:
            day = "Dom."
        case 2:
            day = "Seg."
        case 3:
            day = "Ter."
        case 4:
            day = "Qua."
        case 5:
            day = "Qui."
        case 6:
            day = "Sex."
        case 7:
            day = "Sáb."
        default:
            day = "fail"
        }
        
        return day
    }
}
