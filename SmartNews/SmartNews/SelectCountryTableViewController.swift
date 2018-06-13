//
//  SelectCountryTableViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 11/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class SelectCountryTableViewController: UITableViewController {

    var country: String?

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Country.allCountries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectCountryCell", for: indexPath)
        cell.textLabel?.text = Country.allCountries[indexPath.row].description

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        country = Country.allCountries[indexPath.row].rawValue
        performSegue(withIdentifier: "selectCountryToNews", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCountryToNews" {
            guard let destinationVC = segue.destination as? NewsPresenterTableViewController else {
                return
            }
            destinationVC.country = country
        }
    }
}
