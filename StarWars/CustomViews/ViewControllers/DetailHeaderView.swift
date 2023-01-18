//
//  StarWarsFilmDetailHeaderVoew.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class DetailHeaderView: UIViewController {
    
    // MARK: - Properties
    private let charactersLabel = BUTitleLabel(textAlignment: .center, fontSize: 34)
    
    private var characters = [String]()
    
    // MARK: - Init
    init(characters: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.characters = characters
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    // MARK: - Helpers
    private func setupUI() {
        view.addSubviews(charactersLabel)
        charactersLabel.numberOfLines = 0
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            charactersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureUI() {
        let charactersText = characters.joined(separator: ", ")
        charactersLabel.text = charactersText
    }
}
