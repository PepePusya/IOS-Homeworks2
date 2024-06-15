//
//  PhotosViewController.swift
//  Navigation

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController, ImageLibrarySubscriber {

    private var images: [UIImage] = []
    private var imagePublisherFacade: ImagePublisherFacade?
    private let imageProcessor = ImageProcessor() // Объявляем imageProcessor

    let photoIdent = "photoCell"

    // MARK: Setup section

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Photo Gallery"
        self.view.addSubview(photosCollectionView)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setupConstraints()
        
// zapolnenie collecii neobrabotannimi photo
        images = (1...20).compactMap { UIImage(named: "\($0)") }
        photosCollectionView.reloadData()
        
        // obrabotka photo
        processImagesSequentially()
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

    private func addImages() {
        images = (1...20).compactMap { UIImage(named: "\($0)") }
        photosCollectionView.reloadData()
        processImagesSequentially()
    }

    private func processImagesSequentially() {
        let qosLevels: [QualityOfService] = [.userInteractive, .userInitiated, .utility, .background]
        processNextQoS(qosLevels: qosLevels)
    }

    private func processNextQoS(qosLevels: [QualityOfService], index: Int = 0) {
        guard index < qosLevels.count else { return }
        
        let qos = qosLevels[index]
        let start = CFAbsoluteTimeGetCurrent()
        
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .noir, qos: qos) { [weak self] processedImages in
            guard let self = self else { return }
            self.images = processedImages.compactMap { cgImage -> UIImage? in
                guard let cgImage = cgImage else { return nil }
                return UIImage(cgImage: cgImage)
            }
            
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
                let diff = CFAbsoluteTimeGetCurrent() - start
                print("Processing with \(qos) took \(diff) seconds")
                self.processNextQoS(qosLevels: qosLevels, index: index + 1)
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
