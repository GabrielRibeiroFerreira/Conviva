//
//  CreateEvent2ViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 12/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class CreateEvent2ViewController: UIViewController {
    @IBOutlet weak var costIniciative: TextFieldView!
    @IBOutlet weak var helpersIniciative: TextFieldView!
    @IBOutlet weak var itemsIniciative: TextFieldView!
    @IBOutlet weak var confirme: UIButton!
    
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        Setup.setupButton(confirme, withText: "Finalizar")
        
        self.costIniciative.textField.placeholder = "Qual valor necessita para a iniciativa?"
        self.helpersIniciative.textField.placeholder = "De que ajuda a iniciativa irá precisar?"
        self.itemsIniciative.textField.placeholder = "Quais itens a iniciativa vai precisar?"
    }
    

    // MARK: - Navigation
    @IBAction func confirmeClick(_ sender: Any) {
        self.event.cost = Int(self.costIniciative.textField.text ?? "0")
        self.event.helpers = self.helpersIniciative.textField.text
        self.event.items = self.itemsIniciative.textField.text

        
        if checkEmprtyTextField() {
            //Criação de um evento de teste, mas aqui passaria as informações dos textFields
            let eventTestPOST = Event(name: self.event.name!, description: self.event.description!, address: self.event.address!, cost: self.event.cost! , justification: self.event.justification!, date: self.event.date!, complaint: 0, adm: 23, latitude: -20.7865, longitude: 34.7654)

           //Chamada do método POST para evento
            let postRequest = APIRequest(endpoint: "events")
            postRequest.saveEvent(eventTestPOST) { result in
                switch result {
                case .success(let eventTestPOST):
                    print("O evento foi salvo \(String(describing: eventTestPOST.name))")
                case .failure(let error):
                    print("Ocorreu um erro \(error)")

                }
            }
            //Volta pata lista de eventos
            performSegue(withIdentifier: "unwindToIniciatives", sender: self)
        }
   
    }
    
    
    
    func checkEmprtyTextField() -> Bool {
        var returnValue: Bool = true
        
        //Checando se todos os campos foram completados
        returnValue = textFieldEmpty(self.costIniciative) && returnValue
        returnValue = textFieldEmpty(self.helpersIniciative) && returnValue
        returnValue = textFieldEmpty(self.itemsIniciative) && returnValue
        
        return returnValue
    }
    
    func textFieldEmpty(_ textfieldView : TextFieldView) -> Bool{
        textfieldView.emptyTextndicator.isHidden = textfieldView.textField.text == "" ? false : true
        return textfieldView.emptyTextndicator.isHidden
    }
    
}
