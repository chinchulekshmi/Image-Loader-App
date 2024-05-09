//
//  LoadImagesViewController.swift
//  ImageLoaderApp
//
//  Created by Toqsoft on 06/05/24.
//


import UIKit

class LoadImagesViewController: UIViewController {
    private let manager = APIManager()
    //    let imageCacheManager = ImageCache()
    var dataArray : [ImageModel] = []
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
      //  layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    let images: [UIImage?] = Array(repeating: nil, count: 100) // Placeholder images
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchData()
    }
    func fetchData() {
        Task {
            do {
                let imageResponseArray: [ImageModel] = try await manager.request(url: BaseURL)
                self.dataArray = imageResponseArray
            } catch {
                print(error)
            }
            
            collectionView.reloadData()
        }
        
    }
    
}

extension LoadImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            fatalError("Failed to dequeue ImageCell")
        }
        
        let imageData = dataArray[indexPath.item]
        let imageURL = imageData.thumbnail.domain + "/" + imageData.thumbnail.basePath + "/0/" + imageData.thumbnail.key
        
        // Load image asynchronously
        ImageCache.shared.fetchImage(withURL: imageURL) { image in
            DispatchQueue.main.async {
                // Check if cell is still visible for the given indexPath
                if let currentIndexPath = collectionView.indexPath(for: cell), currentIndexPath == indexPath {
                    cell.imageView.image = image ?? UIImage(named: "placeholder")
                }
            }
        }
        cell.titleLabel.text = imageData.title
        cell.descriptionLabel.text = "\(imageData.publishedBy) on  \(imageData.publishedAt)"
        return cell
    }
    
}
extension LoadImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3.1
        let height: CGFloat

        if UIDevice.current.userInterfaceIdiom == .pad {
            // For iPad
            height = collectionView.frame.height / 3.5
        } else {
            // For iPhone
            height = collectionView.frame.height / 4.5
        }

        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // Adjust this value as needed to achieve the desired spacing between items
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust this value as needed to achieve the desired spacing between rows
    }
    
}



