//
//  FilterTableViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 19/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    let filters: [Filters] = Filters.allValues
    var filterSelected: String?
    var country: String?
    weak var delegate: FilterTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
//        navigationItem.leftBarButtonItem = newBackButton
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterTableViewCell", for: indexPath) as! FilterTableViewCell

        cell.delegate = self
        cell.filterLabel?.text = filters[indexPath.row].rawValue

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Category"
    }

    // MARK: - Private functions

    @IBAction func saveTapped(_ sender: Any) {
        getArticlesAfterFiltered()
        navigationController?.popViewController(animated: true)
    }

    private func getArticlesAfterFiltered() {
        guard let country = country,
            let filter = filterSelected else {
            return
        }
        let networkManager = NetworkManager(country: country)
        networkManager.getFiltredArticles(category: filter) { (articles) in
            self.delegate?.sendArticles(articles)
        }
    }

}

extension FilterTableViewController: FilterTableViewCellDelegate {
    func changeSwitch(forCellWithText text: String, withValue bool: Bool) {
        if bool {
            filterSelected = text
        }
    }
}

protocol FilterTableViewControllerDelegate: class {
    func sendArticles(_ articles: [Article])
}
