//
//  UIActivityIndicatorView+Ext.swift
//  StarWars
//
//  Created by Nov Petrović on 19/01/2023.
//

import UIKit

extension UIActivityIndicatorView {
    
    func showLoading() {
        self.isHidden = false
        self.startAnimating()
    }
    
    func hideLoading() {
        self.isHidden = true
        self.stopAnimating()
    }
}
