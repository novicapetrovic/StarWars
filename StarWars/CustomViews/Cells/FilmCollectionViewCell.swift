//
//  FilmCollectionViewCell.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class FilmCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseId = "FilmCollectionViewCell"
    
    let nameLabel = BUTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(film: FilmModel) {
        nameLabel.text = film.title
    }
    
    private func configure() {
        addSubviews(nameLabel)
        nameLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
