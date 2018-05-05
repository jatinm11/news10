//
//  SourceNewsControllerTwo.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 03/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class sourceNewsControllerTwo {
    
    static var baseURL = URL(string: "https://news10-31394.firebaseio.com/.json")
    
    static var news: [SourceNews] = []
    
    static var count = 1
    
    static var country = ""
    
    static var source: String!
    
    static let shared = sourceNewsControllerTwo()
    
    static var navigationTitle: String = ""
    
    // -----------------------------------------------------------------------------------------------------------------------
    
    // MARK: - USER DEFAULT FUNCTIONS
    
    var savedNews: [SourceNews] = []
    
    func create(title: String, posterEndPoint: String, description: String, url: String) {
        let news = SourceNews(title: title, posterEndPoint: posterEndPoint, description: description, url: url)
        self.savedNews.append(news)
        save()
    }
    
    func save() {
        var arrayOfDictionaries: [[String: Any]] = []
        for i in savedNews {
            arrayOfDictionaries.append(i.dictionaryRepresentation)
        }
        UserDefaults.standard.set(arrayOfDictionaries, forKey: "title")
    }
    
    func load() {
        guard let news = UserDefaults.standard.array(forKey: "title") as? [[String:Any]] else { return }
        var newsArray: [SourceNews] = []
        for j in news {
            guard let news = SourceNews(dictionary: j) else { return }
            newsArray.append(news)
        }
        self.savedNews = newsArray
        
    }
    
    func delete(news: SourceNews) {
        if let index = savedNews.index(of: news) {
            savedNews.remove(at: index)
        }
        save()
    }
    
    // -----------------------------------------------------------------------------------------------------------------------
    
    static func getNews(completion: @escaping(_ success: Bool) -> Void) {
        guard let uURL = baseURL else { completion(false); return }
        
        var request = URLRequest(url: uURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let data = data, let _ = String(data: data, encoding: .utf8) else {
                NSLog("Data was nil.")
                completion(false)
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any], let resultsArrayOfDictionaries = jsonDictionary["articles"] as? [[String:Any]] else {
                    NSLog("The dictionaries not available")
                    completion(false)
                    return
                }
                
                let newsArray = resultsArrayOfDictionaries.flatMap({ SourceNews(dictionary: $0)})
                var newsWithImages: [SourceNews] = []
                let group = DispatchGroup()
                
                for news in newsArray {
                    group.enter()
                    
                    fechImage(imageEndPoint: news.posterEndPoint, completion: { (image) in
                        
                        news.poster = image
                        newsWithImages.append(news)
                        group.leave()
                    })
                }
                
                group.notify(queue: DispatchQueue.main, execute: {
                    self.news = newsWithImages
                    completion(true)
                })
                
                
            } catch {
                NSLog("The JSON wasn't able to be serialize. Error: \(error.localizedDescription)")
                completion(false)
                return
            }
        }
        dataTask.resume()
    }
    
    
    static func fechImage(imageEndPoint: String, completion: @escaping(UIImage?) -> Void ) {
        let baseurl = imageEndPoint
        let basicURL = URL(string: baseurl)
        guard let url = basicURL else { completion(nil) ; return }
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("error no image")
                completion(nil) ; return
            }
            completion(image)
            print("Image fetched \(sourceNewsControllerTwo.count) times")
            sourceNewsControllerTwo.count += 1
        }
        dataTask.resume()
    }
    
}
