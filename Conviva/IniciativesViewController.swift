//
//  IniciativesViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 13/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class IniciativesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var eventTable: UITableView!
    let eventCell : String = "EventsTableViewCell"
    var eventList : [Event] = []
    var months : [(month : String, number : Int)] = [("Novembro", 3), ("Dezembro", 1)]
    var actualDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventTable.delegate = self
        self.eventTable.dataSource = self
        
        let nib = UINib.init(nibName: eventCell, bundle: nil)
        self.eventTable.register(nib, forCellReuseIdentifier: eventCell)
        
        Setup.setupViewController(self)
        
        let event : Event = Event()
        event.name = "Vamo Grande 28/11"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        event.date = formatter.date(from: "28/11/2019 22:31")
//        self.actualDate = event.date
        event.description = "vamo ver se essa coisa funfa, ia ser bom demais se funcionasse de primeira"
        event.local = "Av. Vai Rolar, 161"
        
        self.eventList.append(event)
        self.eventList.append(event)
        
        let event1 : Event = Event()
        event1.name = "Vamo Grande 29/11"
        event1.date = formatter.date(from: "29/11/2019 22:31")
        event1.description = "vamo ver se essa coisa funfa, ia ser bom demais se funcionasse de primeira"
        event1.local = "Av. Vai Rolar, 161"
        self.eventList.append(event1)
        
        let event2 : Event = Event()
        event2.name = "Vamo Grande 29/12"
        event2.date = formatter.date(from: "29/12/2019 22:31")
        event2.description = "vamo ver se essa coisa funfa, ia ser bom demais se funcionasse de primeira"
        event2.local = "Av. Vai Rolar, 161"
        self.eventList.append(event2)
        
    }
    
    // MARK: - TableView

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.months.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var months : [String] = []
        for i in self.months{
            if !months.contains(i.month){
                months.append(i.month)
            }
        }
        return months
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        
        title.backgroundColor = UIColor(named: "ConvivaBackground")
        title.text = self.months[section].month
        title.font = UIFont(name: "Ubuntu-bold", size: 24)
        title.textColor = UIColor(named: "ConvivaPink")
        
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.months[section].number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCell, for: indexPath) as! EventsTableViewCell
        let event : Event = self.eventList[indexPath.row]
        
        cell.setEvent(event)
        cell.backgroundColor = UIColor.clear
        
        if event.date == self.actualDate {
            cell.setDateView(isFirstInSection: true)
        }else{
            cell.setDateView(isFirstInSection: false)
            self.actualDate = event.date
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
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
