//
//  Event.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 11/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation

class Event {
    var name : String?
    var local : String?
    var description : String?
    var image : String?
    var cost : Double?
    var justification : String?
    var date : Date?
    var region : (latitude : String, longitude : String)?
    
    var manager : Profile?
    var interested : [Profile]?
    var helpers : String? //Será junto de items
    var items : String? //[Item]?
    
    init() {
        
    }
}
