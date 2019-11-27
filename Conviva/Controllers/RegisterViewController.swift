//
//  RegisterViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 21/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameProfile: TextFieldView!
    @IBOutlet weak var emailProfile: TextFieldView!
    @IBOutlet weak var addressProfile: TextFieldView!
    @IBOutlet weak var contactProfile: TextFieldView!
    @IBOutlet weak var skillsProfile: TextFieldView!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Setup.setupViewController(self)
        Setup.setupButton(self.registerButton, withText: "Finalizar")
        
        self.nameProfile.textField.placeholder = "Nome Completo"
        self.emailProfile.textField.placeholder = "Email"
        self.addressProfile.textField.placeholder = "Endereço"
        self.contactProfile.textField.placeholder = "Contato"
        self.skillsProfile.textField.placeholder = "Habilidades"
        
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
