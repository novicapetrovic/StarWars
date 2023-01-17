//
//  BUAlertViewController.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class BUAlertViewController: UIViewController {
    
    private let containerView = BUAlertContainerView()
    private let titleLabel = BUTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = BUBodyLabel(textAlignment: .center)
    private let ctaButton = BUButton(backgroundColor: .systemPink, title: "Ok")
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, ctaButton, messageLabel)
        
        configureContainerView()
        configureTitleLabel()
        configureCtaButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureCtaButton() {
        ctaButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        ctaButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            ctaButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            ctaButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            ctaButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            ctaButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissAlert() {
        dismiss(animated: true)
    }
    
    func configureMessageLabel() {
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: ctaButton.topAnchor, constant: -12)
        ])
    }
}
