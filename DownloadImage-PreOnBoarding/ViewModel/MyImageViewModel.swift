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
}

final class MyImageViewModel {
    
    let myImageList: [MyImage] = [
        MyImage(urlString: "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2015/11/16/22/14/cat-1046544_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2018/03/27/17/25/cat-3266673_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2015/08/30/10/58/cat-914110_1280.jpg"),
        MyImage(urlString: "https://cdn.pixabay.com/photo/2015/11/15/22/09/cat-1044914_1280.jpg")
    ]
    
    func downloadImage(urlString: String) async throws -> Data {
        let url = URL(string: urlString)!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw DownloadError.invalidResponse
        }
        return data
    }
}
