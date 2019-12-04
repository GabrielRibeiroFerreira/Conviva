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

    var events: [Event] = []
    let eventCell : String = "EventsTableViewCell"
    
    var months : [(month : String, year: Int,  freq : Int, events: [Event])] = []
    var actualDate : String?
    
    var longitude: Double = -50.0
    var latitude: Double = -20.0
    var radius: Double = 10000.0
    
    var selectEvent : Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setup.setupViewController(self)
        
        self.eventTable.delegate = self
        self.eventTable.dataSource = self
        self.eventTable.indexDisplayMode = .alwaysHidden
           
        let nib = UINib.init(nibName: eventCell, bundle: nil)
        self.eventTable.register(nib, forCellReuseIdentifier: eventCell)
    }
    
    func mockData() {
        let event = Event(name: "Festa Junina", description: "Canjica TOP", address: "Maloca", cost: 500, justification: "Vamo comer canjica", date: "2019-11-01 21:14:23", complaint: 0, adm: 1, latitude: -22.907104, longitude: -47.06324)
        self.events.append(event)
        
        let event0 = Event(name: "Bazar", description: "Roupinhas", address: "Malloca", cost: 500, justification: "Doação", date: "2019-11-22 21:14:23", complaint: 0, adm: 1, latitude: -22.907104, longitude: -47.06324)
        self.events.append(event0)
        
        let event1 = Event(name: "Churrasco na praça", description: "Comer pao de alho", address: "Praça", cost: 500, justification: "To com fome", date: "2019-12-01 21:14:23", complaint: 0, adm: 1, latitude: -22.907104, longitude: -47.06324)
        self.events.append(event1)
         
    }
    
//    func makeAPIRequest() {
//        let getRequest = APIRequest(endpoint: "events")
//        getRequest.getAllEvents() { result in
//            switch result {
//            case .success(let eventsData):
//                print("Lista de eventos: \(String(describing: eventsData))")
//                //Dispatch the call to update the label text to the main thread.
//                //Reload must only be called on the main thread
//                DispatchQueue.main.async{
//                    self.events = eventsData
//                    self.eventTable.reloadData()
//                }
//            case .failure(let error):
//                print("Ocorreu um erro \(error)")
//            }
//        }
//    }
    
    func makeAPIrequest() {
        let getRequest = APIRequest(endpoint: "events")
        
        getRequest.getEventsByRegion(longitude: self.longitude, latitude: self.latitude, radius: self.radius) { result in
            switch result {
            case .success(let eventsData):
                print("Lista de eventos: \(String(describing: eventsData))")
                //Dispatch the call to update the label text to the main thread.
                //Reload must only be called on the main thread
                DispatchQueue.main.async{
                    self.events = eventsData
                    self.eventTable.reloadData()
                }
            case .failure(let error):
                print("Ocorreu um erro \(error)")
            }
        }
    }
    
    //Funcao para agrupar eventos segundo o mês do ano
    func getEventsByMonth() {
        var calendar = Calendar.current
        calendar.locale = NSLocale(localeIdentifier: "pt_BR") as Locale
        
        if self.events.isEmpty {
            return
        }

        //Considerando o array de evento já ordenado por data
        
        // Formato do array months: [(month : String, year: Int,  freq : Int, events: [Event])]
        let calendarDate = getDateComponents(date: self.events[0].dateFormatted!)
        let month = (calendar.monthSymbols[calendarDate.month!-1].capitalized, calendarDate.year!, 1, [self.events[0]])
        self.months = [month]
        var index = 0

        for (prevDate, nextDate) in zip(self.events, self.events.dropFirst()) {
            let calendarDate = getDateComponents(date: nextDate.dateFormatted!)
            var elem = (calendar.monthSymbols[calendarDate.month!-1].capitalized, calendarDate.year!, 1, [nextDate])
            
            
            //Se o mes não existe no array month inclui novo elemento
            if !calendar.isDate(prevDate.dateFormatted!, equalTo: nextDate.dateFormatted!, toGranularity: .month) {
                self.months.append(elem) // Start new row
                index += 1
            }
            //Se é um mes já existente no array months então adiciona com contador inicial de 1
            else {
                var arr = self.months[index].events
                arr.append(nextDate)
                elem.3 = arr
                self.months[index].events = arr
                self.months[index].freq+=1
            }
        }
    }
    
    func getDateComponents(date: Date) -> DateComponents{
        let calendarDate = Calendar.current.dateComponents([.day, .month, .year, .weekday], from: date)
        return calendarDate
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        getEventsByMonth()
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
        return self.months[section].freq
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCell, for: indexPath) as! EventsTableViewCell
        
        let event : Event = self.months[indexPath.section].events[indexPath.row]
        
        cell.setEvent(event)
        cell.backgroundColor = UIColor.clear
        
        // Salva a data atual do bloco, se for diferente exibe a nova data
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
        self.selectEvent = self.months[indexPath.section].events[indexPath.row]
        performSegue(withIdentifier: "toEventSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventSegue"{
            let destination = segue.destination as! EventViewController
            destination.event = self.selectEvent!
        }
    }
    
    // MARK: - Navigation
    @IBAction func createIniciative(_ sender: Any) {
        let email = UserDefaults.standard.string(forKey: "Email")
        if email == "" {
            if let storyboard = self.storyboard {
                let vc  = storyboard.instantiateViewController(identifier: "loginStoryboard")
                self.present(vc, animated: true)
            }
        } else {
            performSegue(withIdentifier: "createSegue", sender: self)
        }
    }
    
    @IBAction func unwindToIniciatives(segue:UIStoryboardSegue) {
        //reload da tableview
    }
    
}
