//
//  News.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 17/04/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class News {
    
    private let titleKey = "title"
    private let posterEndPointKey = "urlToImage"
    private let descriptionKey = "description"
    private let urlKey = "url"
    private let typeKey = "type"
    
    let title: String
    let posterEndPoint: String
    var poster: UIImage?
    let description: String
    let url: String
    let type: String
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary[titleKey] as? String,
            let poster = dictionary[posterEndPointKey] as? String,
            let description = dictionary[descriptionKey] as? String,
            let url = dictionary[urlKey] as? String,
            let type = dictionary[typeKey] as? String
            else { return nil }
        
        self.title = title
        self.posterEndPoint = poster
        self.description = description
        self.url = url
        self.type = type
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [self.titleKey: self.title, self.posterEndPointKey: self.posterEndPoint, self.descriptionKey: self.description, self.urlKey: self.url, self.typeKey: self.type]
    }
    
    init(title: String, posterEndPoint: String, description: String, url: String, type: String) {
        self.title = title
        self.posterEndPoint = posterEndPoint
        self.description = description
        self.url = url
        self.type = type
    }
    
    
}

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.title == rhs.title && lhs.posterEndPoint == rhs.posterEndPoint && lhs.description == rhs.description && lhs.url == rhs.url && lhs.type == rhs.type
    }
}
