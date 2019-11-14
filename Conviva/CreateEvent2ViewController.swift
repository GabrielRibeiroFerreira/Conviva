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
        self.event.cost = Double(self.costIniciative.textField.text ?? "0")
        self.event.helpers = self.helpersIniciative.textField.text
        self.event.items = self.itemsIniciative.textField.text
    }

    /*
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
