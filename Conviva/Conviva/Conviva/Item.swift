//
//  Item.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 11/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation

class Item {
    var name : String
    var amount : Int
    
    var type : ItemType
    
    var event : Event
    var helper : [(person : Profile, amount : Int)]?
    
    init() {
        
    }
}
