//
//  ImagesViewController.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import UIKit
import Kingfisher
import ChameleonFramework


class ImagesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = ImagesViewModel()
    private var items: [ImagesCellViewModel] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = FlatGray()
        collectionView.backgroundColor = FlatGray()
        collectionView.register(.init(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.viewDelegate = self
        viewModel.didViewLoad()
}
    override func viewWillAppear(_ animated: Bool) {
        
        tabBarController?.tabBar.backgroundColor = FlatGray()
    }
    
}

extension ImagesViewController: ImagesViewModelProtocol {
    func didCellItemFetch(_ items: [ImagesCellViewModel]) {
        print(items.count)
        self.items = items
        print("dakssd")
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}

extension ImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        if let url = items[indexPath.row].imageUrl {
            let newUrl = URL(string: url)
            cell.image.kf.setImage(with: newUrl)
            cell.layer.cornerRadius = 8

        }
        return cell
        
    }
    
    
}
extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/4 - 6 , height: collectionView.frame.width/4 - 6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
