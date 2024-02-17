//
//  PostTableVewCell.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/02/17.
//
import UIKit

class PostTableViewCell: UITableViewCell {

    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let postTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(authorImageView)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(postTextLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            authorImageView.widthAnchor.constraint(equalToConstant: 36.0),             authorImageView.heightAnchor.constraint(equalTo: authorImageView.widthAnchor),
            
            authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27.0),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8.0),
            authorNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16.0),
            
            postTextLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 12.0),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            postImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 12.0),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor), //
            
            likesLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16.0),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            viewsLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16.0),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            likesLabel.trailingAnchor.constraint(lessThanOrEqualTo: viewsLabel.leadingAnchor, constant: -8.0),
            
        
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
        ])
    }
    
   
    func configure(with post: Post) {
        authorNameLabel.text = post.author
        postTextLabel.text = post.description
        postImageView.image = UIImage(named: post.imageName)
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
}
