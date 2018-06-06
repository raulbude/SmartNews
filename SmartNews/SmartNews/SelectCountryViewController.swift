//
//  SelectCountryViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 05/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class SelectCountryViewController: UITableViewController {
    // MARK: - Properties

    @IBOutlet weak private var scrollView: UIScrollView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        scrollView.isScrollEnabled = false
    }

    // MARK: - Private Functions

    @IBAction private func expandTapped(_ sender: Any) {
        scrollView.isScrollEnabled = true

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = Country.allCountries[indexPath.item].description

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
