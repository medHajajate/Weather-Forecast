//
//  AddCityViewController.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/6/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var onAdd: ((_ city: City) -> ())?
    
    private var presenter = AddCityPresenter()
    
    private var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddCity))
        viewResult.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func didClickCancel(sender: UIBarButtonItem) {
        dismiss()
    }
    
    @IBAction func didClickDone(sender: UIBarButtonItem) {
        self.AddCity()
    }

    @objc private func AddCity() {
        guard let newCity = self.city else {  return }
        onAdd?(newCity)
    }
    
    func dismiss() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddCityViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.messageLabel.isHidden = true
        self.viewResult.isHidden = true
        self.doneButton.isEnabled = false
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let city = textField.text else { return false }
        self.startActivityIndicator()
        self.presenter.searchCity(city: city)
        return textFiled.resignFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.messageLabel.isHidden = true
        self.viewResult.isHidden = true
        self.doneButton.isEnabled = false
        return true
    }
}

extension AddCityViewController: AddCityPresenterDelegate {
    
    func displayCity(with city: City) {
        self.city = city
        self.stopActivityIndicator()
        self.doneButton.isEnabled = true
        self.viewResult.isHidden = false
        cityLabel.text = city.name
        tempLabel.text = city.temperature + " °C"
        statusLabel.text = city.status
        if city.iconStaus != "" {
            statusIcon.asyncSetImage(with: URL(string: "http://openweathermap.org/img/w/" + city.iconStaus + ".png"))
        }
    }
    
    func displayNotFound() {
        self.stopActivityIndicator()
        messageLabel.isHidden = false
    }
    
    func displayError(_ error: Error) {
        self.stopActivityIndicator()
        self.showError(error: error)
    }
}
