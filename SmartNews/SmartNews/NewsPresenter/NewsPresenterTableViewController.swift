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
    var country: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()

        let nib = UINib.init(nibName: "NewsPresenterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "newsPresenterTableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsPresenterTableViewCell", for: indexPath) as! NewsPresenterTableViewCell
        guard let article = articles?[indexPath.row] else {
            return cell
        }
        cell.titleLabel?.text = article.title
        cell.descriptionLabel?.text = article.description
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()

        return cell
    }
}
