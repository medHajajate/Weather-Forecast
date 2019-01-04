//
//  UIViewController + Extension.swift
//  Weather Forecast
//
//  Created by med hajajate on 1/4/19.
//  Copyright © 2019 med hajajate. All rights reserved.
//

import UIKit
import SDWebImage

extension UIViewController {
    
    // show error
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // show activity indicator
    
    var activityIndicatorTag: Int { return 999999 }
    
    
    func startActivityIndicator() {
        
        DispatchQueue.main.async {
            
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.tag = self.activityIndicatorTag
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    
}


extension UIImageView {
    
    func asyncSetImage(with url: URL?, default: UIImage = #imageLiteral(resourceName: "ExclamationMark")) {
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        addSubview(activityIndicator)
        
        self.image = nil
        SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil) { [weak self] (image, _, _, _, _, _) in
            
            activityIndicator.removeFromSuperview()
            guard let `self` = self else { return }
            
            let image = image ?? `default`
            self.image = image
            
        }
        
    }
}

@IBDesignable extension UIView {
    
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}


