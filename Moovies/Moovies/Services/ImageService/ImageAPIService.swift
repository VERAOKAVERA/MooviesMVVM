// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

//
//  ImageAPIService.swift
//  Moovies
//
//  Created by Vera Zaitseva on 12.10.2021.
//
import Foundation
import UIKit

protocol ImageAPIServiceProtocol: AnyObject {
    func getImage(imagePath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    private let staticImageURL = "https://image.tmdb.org/t/p/w500"

    func getImage(imagePath: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        DispatchQueue.global().async {
            guard let url = URL(string: self.staticImageURL + imagePath),
                  let imageData = try? Data(contentsOf: url),
                  let movieImage = UIImage(data: imageData)
            else {
//                 let error = NSError(domain: "", code: 0, userInfo: nil)
//                 completion(.failure(error))
                return
            }
            DispatchQueue.main.async {
                completion(.success(movieImage))
            }
        }
    }
}
