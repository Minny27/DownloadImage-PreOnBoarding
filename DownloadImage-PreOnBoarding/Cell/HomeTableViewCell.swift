//
//  HomeTableViewCell.swift
//  DownloadImage-PreOnBoarding
//
//  Created by SeungMin on 2023/03/03.
//

import Foundation
import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.fill")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let prograssBarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let prograssBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let downloadButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Load", for: .normal)
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 8
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            myImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        contentView.addSubview(prograssBarContainerView)
        NSLayoutConstraint.activate([
            prograssBarContainerView.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 12),
            prograssBarContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            prograssBarContainerView.widthAnchor.constraint(equalToConstant: 100),
            prograssBarContainerView.heightAnchor.constraint(equalToConstant: 10)
            
        ])
        
        prograssBarContainerView.addSubview(prograssBarView)
        NSLayoutConstraint.activate([
            prograssBarView.topAnchor.constraint(equalTo: prograssBarContainerView.topAnchor),
            prograssBarView.leftAnchor.constraint(equalTo: prograssBarContainerView.leftAnchor),
            prograssBarView.bottomAnchor.constraint(equalTo: prograssBarContainerView.bottomAnchor),
            prograssBarView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(downloadButton)
        NSLayoutConstraint.activate([
            downloadButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            downloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 80),
            downloadButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
