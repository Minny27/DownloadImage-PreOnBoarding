//
//  ImageURL.swift
//  DownloadImage-PreOnBoarding
//
//  Created by SeungMin on 2023/03/07.
//

import Foundation

// fileprivate 키워드를 쓰면 선언한 파일 내부에서만 사용할 수 있음.
fileprivate enum ImageURL {
    private static let imageIds: [String] = [
        "europe-4k-1369012",
        "europe-4k-1318341",
        "europe-4k-1379801",
        "europe-4k-167408",
        "iron-man-323408"
    ]
    
    static subscript(index: Int) -> URL {
        let id = imageIds[index]
        return URL(string: "https://wallpaperaccess.com/download/"+id)!
    }
}
