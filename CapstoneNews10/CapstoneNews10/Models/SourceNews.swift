//
//  SourceNews.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 09/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class SourceNews {
    
    private let titleKey = "title"
    private let posterEndPointKey = "urlToImage"
    private let descriptionKey = "description"
    private let urlKey = "url"
    
    let title: String
    let posterEndPoint: String
    var poster: UIImage?
    let description: String
    let url: String
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary[titleKey] as? String,
            let poster = dictionary[posterEndPointKey] as? String,
            let description = dictionary[descriptionKey] as? String,
            let url = dictionary[urlKey] as? String
            else { return nil }
        
        self.title = title
        self.posterEndPoint = poster
        self.description = description
        self.url = url
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [self.titleKey: self.title, self.posterEndPointKey: self.posterEndPoint, self.descriptionKey: self.description, self.urlKey: self.url]
    }
    
    init(title: String, posterEndPoint: String, description: String, url: String) {
        self.title = title
        self.posterEndPoint = posterEndPoint
        self.description = description
        self.url = url
    }
}

extension SourceNews: Equatable {
    static func == (lhs: SourceNews, rhs: SourceNews) -> Bool {
        return lhs.title == rhs.title && lhs.posterEndPoint == rhs.posterEndPoint && lhs.description == rhs.description && lhs.url == rhs.url
    }
}
