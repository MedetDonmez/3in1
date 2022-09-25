//
//  ViewController.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import UIKit
import ChameleonFramework

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PostsViewModel()
    private var items: [PostsCellViewModel] = []
    
    override func viewDidLoad() {
        view.backgroundColor = FlatSand()
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewDelegate = self
        viewModel.didViewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.backgroundColor = FlatSand()
    }
}


private extension PostsViewController {
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    
    func registerCell() {
        tableView.register(.init(nibName: "PostListTableViewCell", bundle: nil), forCellReuseIdentifier: "PostListTableViewCell")
    }
}

extension PostsViewController: PostsViewModelViewProtocol {
 
    func didCellItemFetch(_ items: [PostsCellViewModel]) {
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
}


extension PostsViewController: UITableViewDelegate {

}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostListTableViewCell") as! PostListTableViewCell
        cell.postTitleLabel.text = items[indexPath.row].title
        cell.postDescLabel.text = items[indexPath.row].desc

        if let colour = FlatSand().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(items.count)) {
            cell.backgroundColor = colour
//            cell.postDescLabel.backgroundColor = FlatSkyBlue()
            cell.postDescLabel.textColor = ContrastColorOf(colour, returnFlat: true)
            cell.postTitleLabel.textColor = ContrastColorOf(colour, returnFlat: true)
        }
        return cell
    }
}
