//
//  LoadingCell.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 17/08/23.
//

import UIKit

class LoadingCell: UITableViewCell {
    internal lazy var loadingView = UIActivityIndicatorView().with(parent: contentView)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        loadingView.color = .systemIndigo
        loadingView.style = .large
        loadingView.makeConstraint {
            $0.centerXAnchor == contentView.centerXAnchor
            $0.topAnchor == contentView.topAnchor + .x16
            $0.bottomAnchor == contentView.bottomAnchor - .x16
        }
    }
}
