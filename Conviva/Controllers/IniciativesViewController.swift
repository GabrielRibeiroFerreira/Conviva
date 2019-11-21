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
    var actualDate : String?
    
    var events: [Event] = []
    
    var selectEvent : Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        
        self.eventTable.delegate = self
        self.eventTable.dataSource = self
        self.eventTable.indexDisplayMode = .alwaysHidden
           
        let nib = UINib.init(nibName: eventCell, bundle: nil)
        self.eventTable.register(nib, forCellReuseIdentifier: eventCell)
    
        makeAPIRequest()
    }
    
    func makeAPIRequest() {
        let getRequest = APIRequest(endpoint: "events")
        getRequest.getAllEvents() { result in
            switch result {
            case .success(let eventsData):
                print("Lista de eventos: \(String(describing: eventsData))")
                DispatchQueue.main.async{
                    self.events = eventsData
                    self.eventTable.reloadData()
                }
            case .failure(let error):
                print("Ocorreu um erro \(error)")
            }
        }
    }
    
    // MARK: - TableView

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.months.count
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
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCell, for: indexPath) as! EventsTableViewCell
        
        let event : Event = self.events[indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectEvent = self.events[0]
        performSegue(withIdentifier: "toEventSegue", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventSegue" {
            let destination = segue.destination as! EventViewController
            destination.event = self.selectEvent!
        }
    }
}
