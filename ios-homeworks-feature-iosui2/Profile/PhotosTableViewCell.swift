//
//  PhotosTableViewCell.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/03/04.
//

import UIKit
import Foundation

class PhotosTableViewCell: UITableViewCell {

    private let photostackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let photoImageView1 = UIImageView()
    private let photoImageView2 = UIImageView()
    private let photoImageView3 = UIImageView()
    private let photoImageView4 = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [photoImageView1, photoImageView2, photoImageView3, photoImageView4].forEach {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            photostackView.addArrangedSubview($0)
        }
        
      
        contentView.addSubview(photostackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photostackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photostackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photostackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            photostackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with images: [UIImage]) {
        let imageViews = [photoImageView1, photoImageView2, photoImageView3, photoImageView4]
        
        for (imageView, image) in zip(imageViews, images) {
            imageView.image = image
        }
    }
}
