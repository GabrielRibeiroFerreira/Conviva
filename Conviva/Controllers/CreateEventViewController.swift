//
//  CreateEventViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 12/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    @IBOutlet weak var titleIniciative: TextFieldView!
    @IBOutlet weak var dateIniciative: TextFieldView!
    @IBOutlet weak var timeIniciative: TextFieldView!
    @IBOutlet weak var localIniciative: TextFieldView!
    @IBOutlet weak var descriptionIniciative: TextFieldView!
    @IBOutlet weak var justificativeIniciative: TextFieldView!
    @IBOutlet weak var nextButton: UIButton!
    
    var event: Event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        Setup.setupButton(self.nextButton, withText: "Avançar")
        
        self.titleIniciative.textField.placeholder = "O que é a iniciativa? (Título)"
        self.dateIniciative.textField.placeholder = "Em qual data?"
        self.timeIniciative.textField.placeholder = "Em qual horário?"
        self.localIniciative.textField.placeholder = "Onde irá acontecer?"
        self.descriptionIniciative.textField.placeholder = "Descreva a iniciativa"
        self.justificativeIniciative.textField.placeholder = "Justificativa"
        
    }

    // MARK: - Navigation
    
    @IBAction func nextClick(_ sender: Any) {
        self.event.name = self.timeIniciative.textField.text
//        self.event.date = self.dateIniciative.textField.text //Passar o valor para data
//        self.event.date = self.timeIniciative.textField.text //Passar o valor para horario
        self.event.address = self.localIniciative.textField.text
        self.event.description = self.descriptionIniciative.textField.text
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextCreateSegue" {
            let destination = segue.destination as! CreateEvent2ViewController
            destination.event = event
        }
    }

}
