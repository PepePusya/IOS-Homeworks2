//
//  PhotosViewController.swift
//  Navigation
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController, ImageLibrarySubscriber {

    private var images: [UIImage] = []
    private var imagePublisherFacade: ImagePublisherFacade?

    let photoIdent = "photoCell"

    // MARK: Setup section

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Photo Gallery"
        self.view.addSubview(photosCollectionView)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setupConstraints()

        imagePublisherFacade = ImagePublisherFacade()
        imagePublisherFacade?.subscribe(self)
        addImagesWithTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagePublisherFacade?.removeSubscription(for: self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    // MARK: Visual objects

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()

    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoIdent)
        return photos
    }()

    // MARK: ImageLibrarySubscriber method

    func receive(images: [UIImage]) {
        self.images = images
        self.photosCollectionView.reloadData()
    }

    private func addImagesWithTimer() {
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if index < 20 {
                if let image = UIImage(named: "\(index + 1)") {
                    self.images.append(image)
                    self.photosCollectionView.reloadData()
                    index += 1
                }
            } else {
                timer.invalidate()
            }
        }
    }
}

// MARK: - Extensions

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 2
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)
        return CGSize(width: widthItem, height: widthItem * 0.56)
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: images[indexPath.item])
        return cell
    }
}
