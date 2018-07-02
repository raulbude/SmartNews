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
    private let urlAll = "https://newsapi.org/v2/everything?"
    private var mapUrl = ""
    var coordinates = (latitude: "", longitude: "") {
        didSet {
            mapUrl = "http://ws.geonames.org/findNearbyPlaceName?lat=\(coordinates.0)&lng=\(coordinates.1)"
        }
    }
    var country: String

    // MARK: - Init

    init(country: String) {
        self.country = country
    }

    // MARK: - Functions

    func getCountryName(completion: @escaping (_ country: String) -> Void) {
        guard let urlJson = URL(string: mapUrl) else {
            return
        }

        URLSession.shared.dataTask(with: urlJson) { (data, response, error) in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? XMLParser {
                if let adressComponents = jsonObj!.value(forKey: "results") as? NSArray {
                   let adress = adressComponents[5] as? NSDictionary
                    let country = adress?.value(forKey: "long_name") as? String
                    completion(country ?? "")
                }

            }
            }.resume()
    }

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
                            let urlToImage = articleDict.value(forKey: "urlToImage") as? String
                            articles.append(Article(title: title ?? "" , author: author ?? "" , description: description ?? "" , articleUrl: url ?? "", datePublished: date ?? "", urlToImage: urlToImage ?? ""))
                        }
                    }
                    completion(articles)
                }

            }
            }.resume()
    }

    func getAllNews(by word: String, completion: @escaping (_ article: [Article]) -> Void) {
        guard let urlJson = URL(string: "\(urlAll)q=\(word)&apiKey=\(apiKey)") else {
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
                            let urlToImage = articleDict.value(forKey: "urlToImage") as? String
                            articles.append(Article(title: title ?? "" , author: author ?? "" , description: description ?? "" , articleUrl: url ?? "", datePublished: date ?? "", urlToImage: urlToImage ?? ""))
                        }
                    }
                    completion(articles)
                }

            }
            }.resume()
    }

    func getFiltredArticles(category: String, completion: @escaping (_ article: [Article]) -> Void) {
        guard let urlJson = URL(string: "\(url)country=\(country)&category=\(category)&apiKey=\(apiKey)") else {
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
                            let urlToImage = articleDict.value(forKey: "urlToImage") as? String
                            articles.append(Article(title: title ?? "" , author: author ?? "" , description: description ?? "" , articleUrl: url ?? "", datePublished: date ?? "", urlToImage: urlToImage ?? ""))
                        }
                    }
                    completion(articles)
                }

            }
            }.resume()
    }
}
