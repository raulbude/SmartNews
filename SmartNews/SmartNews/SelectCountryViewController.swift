//
//  SelectCountryViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 05/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class SelectCountryViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var scrollView: UIScrollView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Functions

    @IBAction private func expandTapped(_ sender: Any) {
    }

}
