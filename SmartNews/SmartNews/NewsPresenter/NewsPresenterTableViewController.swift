//
//  NewsPresenterTableViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 21/04/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class NewsPresenterTableViewController: UITableViewController {
    // MARK: - Properties

    var articles: [Article]?
    var aZ: Bool = false
    var date: Bool = true
    var indexOfArticleToSend = 0
    var country: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = tableView.backgroundColor
        navigationController?.navigationBar.barTintColor = tableView.backgroundColor
        getArticles()

        let nib = UINib.init(nibName: "NewsPresenterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "newsPresenterTableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func sortByAZ(_ sender: Any) {
        aZ = !aZ
        date = false
        tableView.reloadData()
    }

    @IBAction func sortByDate(_ sender: Any) {
        date = true
        aZ = true
        tableView.reloadData()
    }
    
    private func getArticles() {
        let networkManager = NetworkManager(country: country!)
        networkManager.getArticles { (respond: [Article]) in
            self.articles = respond
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func before(value1: Article, value2: Article) -> Bool {
        return value1.title < value2.title
    }

    func after(value1: Article, value2: Article) -> Bool {
        return value1.title > value2.title
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsToDetail" {
            guard let destinationVC = segue.destination as? SelectedNewsViewController else {
                return
            }
            destinationVC.article = articles?[indexOfArticleToSend]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = articles?.count else {
            return 0
        }
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfArticleToSend = indexPath.row
        performSegue(withIdentifier: "newsToDetail", sender: self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsPresenterTableViewCell", for: indexPath) as! NewsPresenterTableViewCell
        guard let article = date ? articles?[indexPath.row] : (aZ ? articles?.sorted(by: before)[indexPath.row] : articles?.sorted(by: after)[indexPath.row]) else {
            return cell
        }
        cell.titleLabel?.text = article.title
        cell.descriptionLabel?.text = article.description
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()

        return cell
    }
}
