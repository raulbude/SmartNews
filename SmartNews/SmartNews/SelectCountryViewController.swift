//
//  SelectCountryViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 05/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class SelectCountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak private var scrollView: UIScrollView!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    private var cellsHeight: CGFloat = 0
    
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
        tableViewHeightConstraint.constant = cellsHeight
        scrollView.isScrollEnabled = true
        scrollView.setContentOffset(tableView.frame.origin, animated: true)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + cellsHeight)
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
    }

    private func setupUI() {
        scrollView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "FirstScreenImage"))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = Country.allCountries[indexPath.item].description
        cellsHeight = indexPath.row == 0 ? cell.frame.height * CGFloat(integerLiteral: Country.allCountries.count) : cellsHeight

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Country.allCountries.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectCountryToTableVC", sender: self)
    }
}
