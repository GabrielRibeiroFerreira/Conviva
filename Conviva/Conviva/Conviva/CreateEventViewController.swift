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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        
        self.titleIniciative.textField.placeholder = "O que é a iniciativa? (Título)"
        self.dateIniciative.textField.placeholder = "Em qual data?"
        self.timeIniciative.textField.placeholder = "Em qual horário?"
        self.localIniciative.textField.placeholder = "Onde irá acontecer?"
        self.descriptionIniciative.textField.placeholder = "Descreva a iniciativa"
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
