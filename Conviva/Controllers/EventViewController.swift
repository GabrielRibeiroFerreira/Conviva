//
//  EventViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 19/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var helpersLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var colabButton: UIButton!
    
    var event : Event!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        
        self.navigationItem.title = event.name
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ConvivaPurple")
  
        self.addressLabel.text = self.event.address
        self.dateLabel.text = self.event.date
        self.descriptionLabel.text = self.event.description
        self.itemsLabel.text = self.event.item
        self.helpersLabel.text = self.event.people
        self.costLabel.text = self.event.cost?.description
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ConvivaBackground")
    }
    
    // BUSCAR NUMERO DE TELEFONE DO ADM
    // LEMBRANDO QUE event.adm É O ID DO ADM
    func getAdmPhoneNumber() -> String {
        return "05535991341301"
    }

    @IBAction func colaborationButton(_ sender: Any) {
        
        let admPhoneNumber = getAdmPhoneNumber()
        let whatsappStringURL = "https://api.whatsapp.com/send?phone=" + admPhoneNumber + "&text=Estou+interessado+em+colaborar+com+sua+iniciativa!"
        
        let whatsappURL = URL(string: whatsappStringURL)
        let appStoreWhatsappURL = URL(string: "https://apps.apple.com/us/app/whatsapp-messenger/id310633997")
        
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, completionHandler: { (sucess) in
            })
        } else {
            UIApplication.shared.open(appStoreWhatsappURL!, completionHandler: { (sucess) in
            })
        }
    }
}
