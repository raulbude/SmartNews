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

    var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var aZ: Bool = false
    var date: Bool = true
    var indexOfArticleToSend = 0
    var country: String?
    var isSelectedAllTapped = false

    @IBOutlet weak var viewWithButtons: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = tableView.backgroundColor

        let nib = UINib.init(nibName: "NewsPresenterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "newsPresenterTableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let frame = viewWithButtons.frame
        viewWithButtons.frame = isSelectedAllTapped ? CGRect(x: 0, y: 0, width: 0, height: 0) : frame
        viewWithButtons.isHidden = isSelectedAllTapped
        tableView.reloadInputViews()
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
            destinationVC.article = articles[indexOfArticleToSend]
        } else if segue.identifier == "newsToFilter" {
            guard let destinationVC = segue.destination as? FilterTableViewController else {
                return
            }
            destinationVC.delegate = self
            destinationVC.country = country
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfArticleToSend = indexPath.row
        performSegue(withIdentifier: "newsToDetail", sender: self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsPresenterTableViewCell", for: indexPath) as! NewsPresenterTableViewCell
        let article = date ? articles[indexPath.row] : (aZ ? articles.sorted(by: before)[indexPath.row] : articles.sorted(by: after)[indexPath.row])

        cell.titleLabel?.text = article.title
        cell.descriptionLabel?.text = article.description
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()

        return cell
    }
}

extension NewsPresenterTableViewController: FilterTableViewControllerDelegate {
    func sendArticles(_ articles: [Article]) {
        self.articles = articles
    }
}
