//
//  IniciativesViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 13/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class IniciativesViewController: UIViewController {
    
    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        Setup.setupViewController(self)
        
        let getRequest = APIRequest(endpoint: "events")
        getRequest.getAllEvents() { result in
            switch result {
            case .success(let eventsData):
                print("Lista de eventos: \(String(describing: eventsData))")
                self.events = eventsData
            case .failure(let error):
                print("Ocorreu um erro \(error)")
                
            }
        }
       
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
