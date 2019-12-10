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
    var admProfile: Profile?
    var admContact: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        Setup.setupButton(colabButton, withText: "Entrar em contato")
        
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
    
    
    
//    func getAdmPhoneNumber() -> String {
//         makeAPIRequest()
//        return "05535991341301"
//    }
    
    func makeAPIRequest() {
        if self.event.adm != nil {
            let getRequest = APIRequest(endpoint: "profiles/id?id=\(self.event.adm!)")
            getRequest.getProfileResponse() { result in
                switch result {
                case .success(let profileData):
                    print("Perfil recuperado: \(String(describing: profileData))")
                    //Dispatch the call to update the label text to the main thread.
                    //Reload must only be called on the main thread
                    DispatchQueue.main.async{
                        self.admProfile = profileData
                        self.admContact = profileData.contact
                        if self.admContact != nil {
                            let phoneNumberValidator = self.admContact!.isPhoneNumber
                            print(phoneNumberValidator)
                            if phoneNumberValidator {
                                self.sendWPP(admPhoneNumber: self.admContact!)
                            }
                        }
                    }
                case .failure(let error):
                    print("Ocorreu um erro \(error)")
                }
            }
        }
    }
    
    func sendWPP(admPhoneNumber: String) {
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
    

    @IBAction func colaborationButton(_ sender: Any) {
        
        makeAPIRequest()
        
      
    }
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
