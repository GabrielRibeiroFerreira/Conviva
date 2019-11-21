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
        
        self.eventTable.delegate = self
        self.eventTable.dataSource = self
        self.eventTable.indexDisplayMode = .alwaysHidden
        
        let nib = UINib.init(nibName: eventCell, bundle: nil)
        self.eventTable.register(nib, forCellReuseIdentifier: eventCell)
        
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
       
        
        let event : Event = Event()
        event.name = "Vamo Grande 28/11"
        event.date = "28/11/2019 22:31"
//        self.actualDate = event.date
        event.description = "Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí. Mas também, pra que levar a sério um texto que não diz nada ou mulheres que são minoria? Afinal, elas somam só 20% da criação. Um número inversamente proporcional a todas as piadas de cunho machista e sexual que elas escutam todos os dias. Sim, todos os dias."
        event.address = "Av. Vai Rolar, 161"
        event.items = "3 panelas, 20 garfos, 20 facas, 1 pa, 2 vassouras"
        event.helpers = "1 fotografo, 3 cozinheiros"
        event.cost = 500
        
        self.eventList.append(event)
        self.eventList.append(event)
        
        let event1 : Event = Event()
        event1.name = "Vamo Grande 29/11"
        event1.date = "29/11/2019 22:31"
        event1.description = "vamo ver se essa coisa funfa, ia ser bom demais se funcionasse de primeira"
        event1.address = "Av. Vai Rolar, 161"
        self.eventList.append(event1)
        
        let event2 : Event = Event()
        event2.name = "Vamo Grande 29/12"
        event2.date = "29/12/2019 22:31"
        event2.description = "vamo ver se essa coisa funfa, ia ser bom demais se funcionasse de primeira"
        event2.address = "Av. Vai Rolar, 161"
        self.eventList.append(event2)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Setup.setupViewController(self)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectEvent = self.eventList[0]
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
