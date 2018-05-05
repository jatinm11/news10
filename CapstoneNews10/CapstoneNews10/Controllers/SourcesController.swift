//
//  SourcesController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 08/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import Foundation

class SourcesController {
    
    static let shared = SourcesController()
    
    static var sources: [Sources] {
        let politics = Sources(name: "Politics", image: #imageLiteral(resourceName: "politics"))
        let sports = Sources(name: "Sports", image: #imageLiteral(resourceName: "Sports"))
        let business = Sources(name: "Business", image: #imageLiteral(resourceName: "business"))
        let technology = Sources(name: "Technology", image:#imageLiteral(resourceName: "Tech"))
        let science = Sources(name: "Science", image: #imageLiteral(resourceName: "Science"))
        let entertainment = Sources(name: "Entertainment", image: #imageLiteral(resourceName: "Entertainment"))
        let gaming = Sources(name: "Gaming", image: #imageLiteral(resourceName: "gaming"))
        let saved = Sources(name: "Saved", image: #imageLiteral(resourceName: "savedIcon"))
        return [business, politics, sports, gaming, science, technology, entertainment, saved]
    }

    
}
