//
//  TitleTableViewCell.swift
//  Netflix Copy
//
//  Created by Mariusz Zając on 25/10/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton ()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlePosterImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applayConstrains()
    }
    
    private func applyConstrains(){
        let titlePosterImageViewConstrains = [
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(titlePosterImageViewConstrains)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: model.posterURL) else {
            return
        }
        titlePosterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
