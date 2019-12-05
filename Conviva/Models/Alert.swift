//
//  Alerts.swift
//  Conviva
//
//  Created by Joyce Simão Clímaco on 04/12/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation
import UIKit

class Alert: UIAlertController {
    
    func presentLocationAlert() -> UIAlertController {
        
        let alertController = UIAlertController (title: "Localização", message: "Seus serviços de localização encontram-se desativados para esse app. Utilizamos  esse serviço para facilitar o encontro da sua região, porém você pode também digitar o endereço desejado. Se desejar, você pode habilitar esse serviço nas suas Configurações.", preferredStyle: .alert)
            
        // Adds settings button action
        let settingsAction = UIAlertAction(title: "Configurações", style: .default) { (_) -> Void in
                
            // Gets the URL for this app's Settings
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            // Opens URL when clicking the button
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (sucess) in
                    print("Settings opened: \(sucess)") // Prints true
                })
            }
        }
        
        // Adds Cancel button action
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        return alertController
    }
}
