//
//  SelectedNewsViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 13/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class SelectedNewsViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionTextView: UITextView!

    @IBOutlet weak private var newsImageView: UIImageView!
    @IBOutlet weak private var shareButton: UIButton!
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI(){
        guard let art = article else {
            return
        }
        titleLabel.text = art.title
        descriptionTextView.text = art.description
        guard let url = URL(string: art.urlToImage),
            let data = try? Data(contentsOf: url) else {
                return
        }
        newsImageView.image = UIImage(data: data)
        newsImageView.contentMode = .scaleAspectFit
    }
}
