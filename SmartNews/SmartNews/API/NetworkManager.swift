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
    var country: String

    // MARK: - Init

    init(country: String) {
        self.country = country
    }

    // MARK: - Functions

    func getArticles(completion: @escaping (_ article: [Article]) -> Void) {
        guard let urlJson = URL(string: "\(url)country=\(country)&apiKey=\(apiKey)") else {
            return
        }
        var articles = [Article]()


        URLSession.shared.dataTask(with: urlJson) { (data, response, error) in

            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let articlesArray = jsonObj!.value(forKey: "articles") as? NSArray {
                    for article in articlesArray {
                        if let articleDict = article as? NSDictionary {
                            let title = articleDict.value(forKey: "title") as? String
                            let description = articleDict.value(forKey: "description") as? String
                            let date = articleDict.value(forKey: "publishedAt") as? String
                            let author = articleDict.value(forKey: "author") as? String
                            let url = articleDict.value(forKey: "url") as? String
                            articles.append(Article(title: title ?? "" , author: author ?? "" , description: description ?? "" , articleUrl: url ?? "", datePublished: date ?? ""))
                        }
                    }
                    completion(articles)
                }

            }
            }.resume()
    }
}
