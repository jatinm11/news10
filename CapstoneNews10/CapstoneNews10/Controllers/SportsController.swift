//
//  SportsController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 01/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import Foundation

class SportsConroller {
    
    static let shared = SportsConroller()
    
    static var sportsSources: [Sports] {
        
        let football = Sports(name: "Football", image: #imageLiteral(resourceName: "football"))
        let soccer = Sports(name: "Soccer", image: #imageLiteral(resourceName: "soccer"))
        let cricket = Sports(name: "Cricket", image: #imageLiteral(resourceName: "cricket"))
    
        return [soccer, football, cricket]
    }
}
