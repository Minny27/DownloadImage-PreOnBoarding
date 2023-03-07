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
    
    let progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.backgroundColor = .systemGray3
        pv.progressTintColor = .systemBlue
        pv.layer.cornerRadius = 8
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        myImageView.image = .init(systemName: "person.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            myImageView.widthAnchor.constraint(equalTo: myImageView.heightAnchor, multiplier: 1),
            myImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75)
        ])
        
        contentView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressView.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 16),
            progressView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        contentView.addSubview(downloadButton)
        NSLayoutConstraint.activate([
            downloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            downloadButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            downloadButton.widthAnchor.constraint(equalTo: downloadButton.heightAnchor, multiplier: 1.5),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
