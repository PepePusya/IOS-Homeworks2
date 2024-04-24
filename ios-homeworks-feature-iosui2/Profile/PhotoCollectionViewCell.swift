//
//  PhotoCollectionViewCell.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/03/09.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    var photo: UIImageView = {
        let photos = UIImageView()
        photos.translatesAutoresizingMaskIntoConstraints = false
        return photos
    }()

    // MARK: - Init section
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("lol")
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Run loop
    
    public func configCellCollection(photo: UIImage) {
        self.photo.image = photo
    }
}

