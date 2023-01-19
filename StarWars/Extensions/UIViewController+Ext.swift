//
//  UIViewController+Ext.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = BUAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultAlert() {
        let alertVC = BUAlertViewController(title: "Something went wrong", message: "We were unable to complet your task at this time. Please try again.", buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
