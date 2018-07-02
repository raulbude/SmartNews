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
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private functions

    @IBAction private func sharePressed(_ sender: UIButton) {
        guard let art = article else {
            return
        }
        let message = "\(art.title)"
        //Set the link to share.
        if let link = NSURL(string: "\(art.articleUrl)")
        {
            let objectsToShare: [Any] = [message,link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }

    }
    private func setupUI(){
        guard let art = article else {
            return
        }
        titleLabel.text = art.title
        descriptionTextView.text = "\(art.description) \n \(art.articleUrl)"
        descriptionTextView.isEditable = false
        descriptionTextView.dataDetectorTypes = .link
        guard let url = URL(string: art.urlToImage),
            let data = try? Data(contentsOf: url) else {
                return
        }
        newsImageView.image = UIImage(data: data)
        newsImageView.contentMode = .scaleAspectFit
    }
}
