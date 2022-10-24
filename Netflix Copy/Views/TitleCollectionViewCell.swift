//
//  TitleCollectionViewCell.swift
//  Netflix Copy
//
//  Created by Mariusz Zając on 24/10/2022.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "TitleCollectionViewCell"
    private let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    required init?(coder:NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    
}
