//
//  WeatherDetailsViewController.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityName: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...", attributes: nil)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        return refreshControl
    }()
    
    let presenter = WeatherDetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.cornerRadius(10)
        cityName.text = presenter.city?.name
        self.tableView.refreshControl = refreshControl
        presenter.setDelegate(delegate: self)
        presenter.viewDidLoad()
    }
    
    @objc private func refreshWeatherData() {
        self.presenter.refreshData()
    }

}

extension WeatherDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.weatherDaysCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsViewCell", for: indexPath) as! DetailsViewCell
        cell.update(with: presenter.weatherDay(index: indexPath.row))
        return cell
    }
    
    
}

extension WeatherDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WeatherDetailsViewController: WeatherDetailsPresenterDelegate {
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
