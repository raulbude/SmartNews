//
//  NetworkManager.swift
//  SmartNews
//
//  Created by Raul Bude on 30/04/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import Foundation

final class NetworkManager {
    // MARK: - Properties

    private let apiKey = "0339733e1f14441db2e9f904e2290ef9"
    private let url = "https://newsapi.org/v2/top-headlines?"
    private(set) var articles = [Article]()
    var country: String
    var category: String

    // MARK: - Init

    init(country: String, category: String) {
        self.country = country
        self.category = category
    }

    // MARK: - Functions

    func getJson() {
        guard let urlJson = URL(string: "\(url)country=\(country)&category=\(category)&apiKey=\(apiKey)") else {
            return
        }

        URLSession.shared.dataTask(with: urlJson) { (data, response, error) in

            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {

                //getting the avengers tag array from json and converting it to NSArray
                if let articlesArray = jsonObj!.value(forKey: "articles") as? NSArray {
                    //looping through all the elements
                    for article in articlesArray {
                        if let articleDict = article as? NSDictionary {
                            guard let title = articleDict.value(forKey: "title") as? String,
                                let description = articleDict.value(forKey: "description") as? String,
                                let date = articleDict.value(forKey: "publishedAt") as? String,
                                let author = articleDict.value(forKey: "author") as? String,
                                let url = articleDict.value(forKey: "url") as? String else {
                                    return
                            }
                            self.articles.append(Article(title: title, author: author, description: description, articleUrl: url, datePublished: date))
                        }
                    }
                }

                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
//                    self.showNames()
                })
            }
            }.resume()
    }
}
