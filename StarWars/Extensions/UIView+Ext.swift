//
//  UIView+Ext.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}

// Pull to refresh
// Test coverage
// Documentation
// Project structure refactor/cleanup
// MVC, MVVM
// Detail viewcontroller having tableview
// Stretch character detail
// Add launch screen
// Refactor networking to async/await
