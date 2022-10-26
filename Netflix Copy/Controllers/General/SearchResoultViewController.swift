//
//  SearchResoultViewController.swift
//  Netflix Copy
//
//  Created by Mariusz Zając on 26/10/2022.
//

import UIKit

class SearchResoultViewController: UIViewController {
   
    public var titles: [Title] = [Title]()

    public let searchResoultsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResoultsCollectionView)
        searchResoultsCollectionView.delegate = self
        searchResoultsCollectionView.dataSource = self
        
        
    }
    override func viewDidLayoutSubviews() {
        searchResoultsCollectionView.frame = view.bounds
    }

  
}
extension SearchResoultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
}
