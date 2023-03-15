//
//  MyImageViewModel.swift
//  DownloadImage-PreOnBoarding
//
//  Created by SeungMin on 2023/03/03.
//

import Foundation
import UIKit

enum DownloadError: Error {
    case invalidResponse
    case invalidData
    case invalidURL
    case error
}

final class MyImageViewModel {
    
    let myImageList: [MyImage] = [
        MyImage(urlString: "https://cdn.pixabay.com/photo/2015/11/16/22/14/cat-1046544_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2015/08/30/10/58/cat-914110_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2015/11/15/22/09/cat-1044914_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2018/03/27/17/25/cat-3266673_1280.jpg")
    ]
    var task: URLSessionDataTask!
    var observation: NSKeyValueObservation!
    var progress: Float = 0.0
    var downloadProcessHandler: ((Progress, NSKeyValueObservedChange<Double>) -> Void)!
    
    func downloadImage(from urlString: String, completion: @escaping ((UIImage?) -> ())) async throws {
        guard let url = URL(string: urlString) else {
            throw DownloadError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let urlSession = URLSession.shared
        task = urlSession.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print(DownloadError.invalidResponse)
                return
            }
            
            guard let data = data, error == nil else {
                print(DownloadError.error)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print(DownloadError.invalidData)
                return
            }
            
            self.progress = 1.0
            completion(image)
        }
        task.resume()
        
        observation = task.progress.observe(\.fractionCompleted,
                                             options: [.new],
                                             changeHandler: { progress, change in
            
            self.progress = Float(progress.fractionCompleted)
            completion(nil)
        })
    }
}
