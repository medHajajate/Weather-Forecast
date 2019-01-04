//
//  CitiesListViewController.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private  var presenter = CitiesListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.viewDidLoad()
    }
}

extension CitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.citiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherViewCell", for: indexPath) as! CityWeatherViewCell
        let city = presenter.city(index: indexPath.row)
        cell.update(with: city)
        return cell
    }
    
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CitiesListViewController: CitiesListPresenterDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func startIndicator() {
        self.startActivityIndicator()
    }
    
    func stopIndicator() {
        self.stopActivityIndicator()
    }
    
    func displayError(_ error: Error) {
        self.showError(error: error)
    }
}
