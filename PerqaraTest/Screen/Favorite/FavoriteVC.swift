//
//  FavoriteVC.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import UIKit

class FavoriteVC: UIViewController {
    private lazy var topView = UIView().with(parent: view)
    private lazy var tableView = UITableView().with(parent: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopView()
        setupTableView()
    }
    
    private func setupTopView() {
        topView.backgroundColor = .systemIndigo
        topView.makeConstraint {
            $0.topAnchor == view.topAnchor
            $0.leadingAnchor == view.leadingAnchor
            $0.trailingAnchor == view.trailingAnchor
        }
        let titleLabel = UILabel().with(parent: topView)
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "Favorite Games"
        titleLabel.makeConstraint {
            $0.leadingAnchor == topView.leadingAnchor + .x16
            $0.topAnchor == view.safeAreaLayoutGuide.topAnchor + .x16
            $0.bottomAnchor == topView.bottomAnchor - .x16
        }
    }
    
    private func setupTableView() {
        tableView.makeConstraint {
            $0.topAnchor == topView.bottomAnchor
            $0.leadingAnchor == view.leadingAnchor
            $0.trailingAnchor == view.trailingAnchor
            $0.bottomAnchor == view.bottomAnchor
        }
    }
}
