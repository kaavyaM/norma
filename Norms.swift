//
//  Norms.swift
//  Corgis
//
//  Created by Sal Valdes on 11/11/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class Norm {
    
    //MARK: Properties
    
    var name: String
    var reason: String?
    var rating: Int
    var id: Int
    
    //MARK: Initialization
    
    init?(name: String, reason: String?, rating: Int, id: Int) {
        
        // Name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusive
        guard (rating >= 0) && (rating <= 3) else {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.reason = reason
        self.rating = rating
        self.id = id
    }
    
}
