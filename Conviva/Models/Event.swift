//
//  Event.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 11/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation

//Codable implementa o protocolo de Encodable e Decodable
class Event: Codable {
    var name : String?
    var address : String?
    var description : String?
    var cost : Int?
    var justification : String?
    var date : String?
    var complaint: Int?
    
    var image : String?
    var latitude: Double?
    var longitude: Double?
    var adm: Int?
    
// Não pode conter um array para cumprir o protocolo Codable
// Acho que existe uma forma de conter array mas não me preocupei no inicio
//    var manager : Profile?
//    var interested : [Profile]?
    var helpers : String? //Será junto de items
    var items : String? //[Item]?
    
    init(name: String, description: String, address: String, cost: Int, justification: String, date: String, complaint: Int, adm: Int, latitude: Double, longitude: Double) {
        self.name = name
        self.description = description
        self.address = address
        self.cost = cost
        self.justification = justification
        self.date = date
        self.complaint = complaint
        self.adm = adm
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init() {
        
    }
}
