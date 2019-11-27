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
    
    var event : Event!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        
        self.navigationItem.title = event.name
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ConvivaPurple")
  
        self.addressLabel.text = self.event.address
        self.dateLabel.text = self.event.date
        self.descriptionLabel.text = self.event.description
        self.itemsLabel.text = self.event.items
        self.helpersLabel.text = self.event.helpers
        self.costLabel.text = self.event.cost?.description
        
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "ConvivaBackground")
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
