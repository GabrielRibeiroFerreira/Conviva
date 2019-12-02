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
    @IBOutlet weak var passwordProfile: TextFieldView!
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
        self.passwordProfile.textField.placeholder = "Senha"
        
    }
    

    func checkForEmptyTextField() -> Bool {
        var returnValue: Bool = true
          
        //Checando se todos os campos foram completados
        returnValue = textFieldEmpty(self.nameProfile) && returnValue
        returnValue = textFieldEmpty(self.emailProfile) && returnValue
        returnValue = textFieldEmpty(self.addressProfile) && returnValue
        returnValue = textFieldEmpty(self.contactProfile) && returnValue
        returnValue = textFieldEmpty(self.skillsProfile) && returnValue
        returnValue = textFieldEmpty(self.passwordProfile) && returnValue
          
        return returnValue
      }
      
      func textFieldEmpty(_ textfieldView : TextFieldView) -> Bool{
          textfieldView.emptyTextndicator.isHidden = textfieldView.textField.text == "" ? false : true
          return textfieldView.emptyTextndicator.isHidden
      }
      
      
    func makeAPIRequest() {
        if checkForEmptyTextField() {
            //Ver forma de pegar lat/long/rad da seleção inicial
            let newProfile = Profile(name: self.nameProfile.textField.text!, email: self.emailProfile.textField.text!, password: self.passwordProfile.textField.text!, contact: self.contactProfile.textField.text!, address: self.addressProfile.textField.text!, description: self.skillsProfile.textField.text!, latitude: -20.7865, longitude: 34.7654, radius: 10000)

              //Chamada do método POST para profile
              let postRequest = APIRequest(endpoint: "profiles")
              postRequest.saveProfile(newProfile) { result in
                switch result {
                  case .success(let newProfile):
                     print("O evento foi salvo \(String(describing: newProfile.name))")
                     self.dismiss(animated: true)
                  case .failure(let error):
                     print("Ocorreu um erro \(error)")
                     //UIALERT
                 }
             }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        if checkForEmptyTextField() {
            makeAPIRequest()
        }
 
    }
    
}
