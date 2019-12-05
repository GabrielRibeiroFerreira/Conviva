//
//  ProfileViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 27/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameProfile: TextFieldView!
    @IBOutlet weak var emailProfile: TextFieldView!
    @IBOutlet weak var addressProfile: TextFieldView!
    @IBOutlet weak var contactProfile: TextFieldView!
    @IBOutlet weak var skillsProfile: TextFieldView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        Setup.setupButton(self.saveButton, withText: "Salvar")
        
        self.nameProfile.textField.placeholder = "Nome"
        self.emailProfile.textField.placeholder = "Email"
        self.addressProfile.textField.placeholder = "Endereço"
        self.contactProfile.textField.placeholder = "Contato"
        self.skillsProfile.textField.placeholder = "Habilidades"
        
        makeAPIRequest()
        
    }
    
    func makeAPIRequest() {
        let id = UserDefaults.standard.integer(forKey: "ID")
        let getRequest = APIRequest(endpoint: "profiles/id?id=\(id)")
        getRequest.getProfileResponse() { result in
            switch result {
            case .success(let eventsData):
                print("Lista de eventos: \(String(describing: eventsData))")
                //Dispatch the call to update the label text to the main thread.
                //Reload must only be called on the main thread
                DispatchQueue.main.async{
                    self.nameProfile.textField.placeholder = eventsData.name
                    self.emailProfile.textField.placeholder = eventsData.email
                    self.addressProfile.textField.placeholder = eventsData.address
                    self.contactProfile.textField.placeholder = eventsData.contact
                    self.skillsProfile.textField.placeholder = eventsData.description

                }
            case .failure(let error):
                print("Ocorreu um erro \(error)")
            }
        }
    }
  

    @IBAction func saveEdit(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "Email")

    }
    
    //Limpar UserDefaults quando deslogar
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "Email")
        UserDefaults.standard.set(nil, forKey: "ID")
    }
    
    
}
