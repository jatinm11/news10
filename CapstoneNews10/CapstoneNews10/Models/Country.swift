//
//  Country.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 14/03/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class Country {
    
    var countryName: String
    var imageName: String
    
    init(countryName: String, imageName: String) {
        self.countryName = countryName
        self.imageName = imageName
    }
    
    init?(dictionary: [String: Any]) {
        guard let countryName = dictionary["countryName"] as? String, let imageName = dictionary["imageName"] as? String else { return nil }
        
        self.countryName = countryName
        self.imageName = imageName
    }
    
    var dictionaryRepresentation: [String : Any] {
        return ["countryName" : self.countryName, "imageName": self.imageName]
    }
}
