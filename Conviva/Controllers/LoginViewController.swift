//
//  LoginViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 25/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailProfile: TextFieldView!
    @IBOutlet weak var passwordProfile: TextFieldView!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Setup.setupViewController(self)
        Setup.setupButton(self.signinButton, withText: "Entrar")
        
        self.emailProfile.textField.placeholder = "email"
        self.passwordProfile.textField.placeholder = "senha"
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
