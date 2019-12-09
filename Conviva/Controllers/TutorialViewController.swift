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
    }
    

    @IBAction func nextPage(_ sender: Any) {
        let pageWidth : CGFloat = self.view.frame.width
        let contentOffset : CGFloat = self.scrollView.contentOffset.x
        let slideToX = contentOffset + pageWidth
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
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
