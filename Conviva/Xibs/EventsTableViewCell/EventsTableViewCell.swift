//
//  EventsTableViewCell.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 14/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayEvent: UILabel!
    @IBOutlet weak var weekdayEvent: UILabel!
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var descriptionEvent: UILabel!
    @IBOutlet weak var addressEvent: UILabel!
    
    var isFirstInSection : Bool = true
    var isFirstCall : Bool = true
    
    override func draw(_ rect: CGRect) {
        self.dayEvent.font = UIFont(name: "Ubuntu-bold", size: 24)
        self.weekdayEvent.font = UIFont(name: "Ubuntu-bold", size: 12)
        self.titleEvent.font = UIFont(name: "Ubuntu-bold", size: 24)
        self.descriptionEvent.font = UIFont(name: "Roboto", size: 14)
        self.addressEvent.font = UIFont(name: "Ubuntu-bold", size: 16)
    }
    
    func setEvent(_ event : Event) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = formatter.date(from: event.date!)
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month, .weekday], from: date!)
        self.dayEvent.text = String(calanderDate.day!)
        self.weekdayEvent.text = Setup.setupWeekday(calanderDate.weekday!)
        self.titleEvent.text = event.name
        self.descriptionEvent.text = event.description
        self.addressEvent.text = event.address
    }
    
    func setDateView(isFirstInSection : Bool){
        if self.isFirstCall {
            self.isFirstInSection = isFirstInSection
            self.isFirstCall = false
        }
        
        self.dateView.isHidden = self.isFirstInSection ? true : false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
