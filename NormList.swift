//
//  NormList.swift
//  Corgis
//
//  Created by Sal Valdes on 12/3/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import Foundation

import UIKit

class NormList {
    
    //MARK: Properties
    
    private var norms = [Norm]()
    private var currentId: Int
    
    //MARK: Initialization
    
    init() {
        currentId = 0
        loadSampleNorms()
    }
    
    //MARK: Public getters / setters
    func get(index: Int)->Norm {
        return norms[index]
    }
    
    func count()-> Int {
        return norms.count
    }
    
    func changeRating(id: Int, newRating: Int) {
        for norm in norms {
            if id == norm.id {
                norm.rating = newRating
            }
        }
    }
    
    func appendReason(id: Int, additionalReason: String) {
        for norm in norms {
            if id == norm.id {
                if (norm.reason != nil) {
                    norm.reason = (norm.reason! + "\n" + additionalReason)
                } else {
                    norm.reason = additionalReason
                }
                
            }
        }
    }
    
    func add(name: String, reason: String) {
        guard let norm = Norm(name: name, reason: reason, rating: 0, id: currentId) else {
            fatalError("Failed to create norm")
        }
        norms += [norm]
        currentId += 1
    }
    
    //MARK: Private methods
    
    
    private func loadSampleNorms() {
        let reason1 = "We feel like it's common courtesy to not enter someone's personal space, So before you touch someone's hair or clothing, make sure you have verbal consent."
        
        self.add(name: "Respect personal space", reason: reason1)
        
        self.add(name: "Don't interrupt during meetings", reason: "It's important that everyone feels listened to in meetings.")
        self.changeRating(id: 1, newRating: 3)
        
        self.add(name: "Don't microwave fish", reason: "This is because of you, Dave.")
        self.changeRating(id: 2, newRating: 1)
    }
    
    
    
}
