//
//  CollectionVievTableViewCell.swift
//  Netflix Copy
//
//  Created by Mariusz Zając on 23/10/2022.
//

import UIKit

protocol CollectionVievTableViewCellDelegate: AnyObject {
    func collectionVievTableViewCellDidTapCell(_ cell: CollectionVievTableViewCell, viewModel: TitlePreviewViewModel)
}


class CollectionVievTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionVievTableViewCell"
    
    weak var delegate: CollectionVievTableViewCellDelegate?
    
    private var titles: [Title] = [Title] ()
    
    private let collectionViev: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionViev)
        
        collectionViev.delegate = self
        collectionViev.dataSource = self
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionViev.frame = contentView.bounds
    }
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async {
            [weak self] in self?.collectionViev.reloadData()
        }
    }
}
extension CollectionVievTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as?TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        APICaller.shared.getMovie(with: titleName + "trailer") {
            result in
            switch result {
            case .success(let VideoElement):
                print(VideoElement.id)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

