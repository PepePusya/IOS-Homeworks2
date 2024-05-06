import UIKit
import StorageService
import SnapKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    private var viewCounter = 0

    // MARK: Visual objects
    
    var postAuthor: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    var postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    var postDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    var postLikes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    var postViews: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    // MARK: - Init section
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviews(postAuthor, postImage, postDescription, postLikes, postViews)
    }
    
    private func setupConstraints() {
        postAuthor.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        postImage.snp.makeConstraints { make in
            make.top.equalTo(postAuthor.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(postImage.snp.width).multipliedBy(0.56)
        }
        
        postDescription.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        postLikes.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        postViews.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: - Configure cell
    
    func configPost(post: Post) {
        postAuthor.text = post.author
        postDescription.text = post.description
        postLikes.text = "Likes: \(post.likes)"
        postViews.text = "Views: \(post.views)"
        
        if let image = UIImage(named: post.image) {
            let processor = ImageProcessor()
            processor.processImage(sourceImage: image, filter: .noir) { [weak self] processedImage in
                DispatchQueue.main.async {
                    self?.postImage.image = processedImage
                }
            }
        }
    }
    
    func incrementPostViewsCounter() {
        viewCounter += 1
        postViews.text = "Views: \(viewCounter)"
    }
}
