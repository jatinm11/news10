//
//  CountryController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 14/03/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class CountryController {
    
    static let shared = CountryController()
    
    var countries: [Country] = []
    
    var defaultCountries: [Country] {
        
        let india = Country(countryName: "Republic of India", imageName: "indiabg")
        let us = Country(countryName: "United States", imageName: "usabg")
        let uk = Country(countryName: "United Kingdom", imageName: "londonbg")
        
        return [us, india, uk]
    }
    
    func createCountry(countryName: String, countryImage: String) {
        let country = Country(countryName: countryName, imageName: countryImage)
        countries.append(country)
        save()
    }
    
    func save() {
        var arrayOfDictionaries: [[String: Any]] = []
        for i in countries {
            arrayOfDictionaries.append(i.dictionaryRepresentation)
        }
        UserDefaults.standard.set(arrayOfDictionaries, forKey: "country")
    }
    
    func load() {
        guard let country = UserDefaults.standard.value(forKey: "country") as? [[String: Any]] else { return }
        
        var countries: [Country] = []
        
        for i in country {
            let country = Country(dictionary: i)
            countries.append(country!)
        }
        
        self.countries = countries
    }
}
