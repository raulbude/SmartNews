//
//  MapSelectCountryViewController.swift
//  SmartNews
//
//  Created by Raul Bude on 23/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit
import MapKit

class MapSelectCountryViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var searchBy: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    let centralEuropeCoordinate = CLLocationCoordinate2D(latitude: 48.920027, longitude: 12.331714)
    let segueIdentifier = "toSelectedCountry"
    var isSelectAllTapped = false
    var locationManager = CLLocationManager()
    var articles: [Article] = []
    var country = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        searchBy.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        setupMap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        isSelectAllTapped = false
        mapView.delegate = self
        setupMap()
    }

    @IBAction private func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)

        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                return
            } else if let country = placemarks?.first?.country {
                let countryKey = Country.getCountryKey(from: " \(country)")
                if countryKey == "No Country" {
                    self.showAlert()
                }
                self.country = countryKey
                let networkManager = NetworkManager(country: countryKey)
                networkManager.getArticles(completion: { (articles) in
                    self.articles = articles
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: self.segueIdentifier, sender: self)
                    }
                })
            }
            else {
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let destinationVC = segue.destination as? NewsPresenterTableViewController else {
                return
            }
            searchBy.resignFirstResponder()
            destinationVC.isSelectedAllTapped = isSelectAllTapped
            destinationVC.country = country
            destinationVC.articles = articles
        }
    }

    @IBAction func selectAllTapped(_ sender: Any) {
        let networkManager = NetworkManager(country: "")
        guard let text = searchBy.text else {
            return
        }
        networkManager.getAllNews(by: text, completion: { (articles) in
            self.articles = articles
            self.isSelectAllTapped = true
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: self.segueIdentifier, sender: self)
            }
        })
    }

    private func showAlert() {
        let alert = UIAlertController(title: "No news for this country!", message: "Select another country", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func setupMap() {
        mapView.setRegion(MKCoordinateRegion(center: centralEuropeCoordinate, span: MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60)), animated: true)
    }
}

extension MapSelectCountryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
