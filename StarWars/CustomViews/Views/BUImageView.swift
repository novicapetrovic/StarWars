//
//  BUFilmImageView.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class BUImageView: UIImageView {
    
    private let cache = NetworkManager.shared.cache
    private let placeholderImage = UIImage(named: "placeholder-image")
    private var count = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        setPlaceholderImage()
    }
    
    func setPlaceholderImage() {
        image = placeholderImage
    }
}
