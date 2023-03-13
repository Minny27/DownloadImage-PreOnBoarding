//
//  HomeViewController.swift
//  DownloadImage-PreOnBoarding
//
//  Created by SeungMin on 2023/03/03.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let myImageViewModel = MyImageViewModel()
    private var observation: NSKeyValueObservation!
    
    private let homeTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(HomeTableViewCell.self,
                    forCellReuseIdentifier: HomeTableViewCell.identifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let allImageDownloadButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Load All Images", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 10
        
        bt.addTarget(self,
                     action: #selector(allImageDownloadButtonTapped(_:)),
                     for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupDelegate()
    }
    
    private func setupConstraints() {
        view.addSubview(homeTableView)
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        view.addSubview(allImageDownloadButton)
        NSLayoutConstraint.activate([
            allImageDownloadButton.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                         constant: 20),
            allImageDownloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                           constant: -20),
            allImageDownloadButton.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                          constant: -20),
            allImageDownloadButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func setupDelegate() {
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    
    private func reset(cell: HomeTableViewCell) {
        cell.myImageView.image = .init(systemName: "person.fill")
        cell.progressView.progress = 0
    }
    
    @objc func allImageDownloadButtonTapped(_ sender: UIButton) {
        Task.detached(operation: {
            for index in 0..<self.myImageViewModel.myImageList.count {
                let indexPath = IndexPath(row: index, section: 0)
                let cell = await self.homeTableView.cellForRow(at: indexPath) as! HomeTableViewCell
                await self.reset(cell: cell)
                
                try await self.myImageViewModel.downloadImage(from: self.myImageViewModel.myImageList[index].urlString) { image, progress in
                    DispatchQueue.main.async {
                        cell.progressView.progress = Float(progress.fractionCompleted)
                        
                        guard let image = image else {
                            print(DownloadError.invalidData)
                            return
                        }
                        cell.myImageView.image = image
                    }
                }
            }
        })
    }
    
    @objc func downloadButtonTapped(_ sender: UIButton) {
        Task.detached(operation: {
            let indexPath = await IndexPath(row: sender.tag, section: 0)
            let cell = await self.homeTableView.cellForRow(at: indexPath) as! HomeTableViewCell
            await self.reset(cell: cell)
            
            try await self.myImageViewModel.downloadImage(from: self.myImageViewModel.myImageList[sender.tag].urlString) { image, progress in
                DispatchQueue.main.async {
                    cell.progressView.progress = Float(progress.fractionCompleted)
                    
                    guard let image = image else {
                        print(DownloadError.invalidData)
                        return
                    }
                    cell.myImageView.image = image
                }
            }
        })
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myImageViewModel.myImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                 for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        cell.downloadButton.tag = indexPath.row
        cell.downloadButton.addTarget(self,
                                      action: #selector(downloadButtonTapped(_:)),
                                      for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
