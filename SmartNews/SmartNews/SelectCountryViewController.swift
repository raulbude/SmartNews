//
//  SelectCountryViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 05/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class SelectCountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak private var scrollView: UIScrollView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scrollView.isScrollEnabled = false
    }

    // MARK: - Private Functions

    @IBAction private func expandTapped(_ sender: Any) {
        scrollView.isScrollEnabled = true
        scrollView.setContentOffset(tableView.frame.origin, animated: true)
    }

    private func setupUI() {
        scrollView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "FirstScreenImage"))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = Country.allCountries[indexPath.item].description

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Country.allCountries.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
