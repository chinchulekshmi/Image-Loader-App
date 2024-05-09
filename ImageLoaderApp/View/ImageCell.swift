//
//  ImageCell.swift
//  ImageLoaderApp
//
//  Created by Toqsoft on 08/05/24.
//

import Foundation
import UIKit
class ImageCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // Ensures content is clipped to the bounds of the image view
        return imageView
    }()
    // Define label1
     let titleLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.textColor = .black
         label.font = UIFont.boldSystemFont(ofSize: 12)
     
         // Customize other properties as needed
         return label
     }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 9)

        // Customize other properties as needed
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        // Assuming you have two labels named label1 and label2
        let imageViewWidth = contentView.frame.width // Square image view

        NSLayoutConstraint.activate([
            // Image View Constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // Square image view
            // constraints for titleLabel
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //  constraints for descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])

        
        
 
    }
    
 
    
    
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setupCell()
      }
      
      private func setupCell() {
          // Set border width and color
          layer.borderWidth = 1.0
          layer.borderColor = UIColor.black.cgColor
      }
}
