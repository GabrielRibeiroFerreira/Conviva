//
//  TutorialViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 04/12/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        Setup.setupButton(self.button1, withText: "Avançar")
        Setup.setupButton(self.button2, withText: "Começar")
        
        
//          let email = UserDefaults.standard.string(forKey: "Email")
//
//          if email != nil {
//              self.performSegue(withIdentifier: "toTab", sender: self)
//          }
        
      
    }

    @IBAction func nextPage(_ sender: Any) {
        let pageWidth : CGFloat = self.view.frame.width
        let contentOffset : CGFloat = self.scrollView.contentOffset.x
        let slideToX = contentOffset + pageWidth
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
}
