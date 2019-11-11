//
//  Profile.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 11/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation

class Profile {
    var name : String
    var email : String
    var password : String
    var contact : String
    var address : String?
    var descrition : String?
    var region : (latitude : String, longitude : String, radius : Double)
    
    var managedEvents : [Event]?
    var interestedEvents : [Event]?
    
    var helpItems : [Item]?
    
    init() {
        
    }
}
