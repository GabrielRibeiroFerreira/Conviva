//
//  EventViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 19/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    var event : Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        
        self.navigationItem.title = event.name
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ConvivaPurple")
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "CEM"), for: .defaultPrompt)
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
  
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
