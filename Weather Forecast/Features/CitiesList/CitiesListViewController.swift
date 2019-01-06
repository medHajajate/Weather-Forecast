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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...", attributes: nil)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        presenter.setDelegate(delegate: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetails":
            let details = segue.destination as! WeatherDetailsViewController
            details.presenter.city = sender as? City
        case "AddCity":
            let navBarController = segue.destination as! UINavigationController
            let addCityController = navBarController.topViewController as! AddCityViewController
            addCityController.onAdd = { city in
                self.presenter.addNewCity(city: city)
                addCityController.dismiss()
            }
        default:
            break
        }
    }
    
    @objc private func refreshWeatherData() {
        self.presenter.refreshData()
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
        performSegue(withIdentifier: "showDetails", sender: self.presenter.city(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeCity(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
        }
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
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }

}
