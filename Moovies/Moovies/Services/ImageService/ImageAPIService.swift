// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

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
            else { return }
            DispatchQueue.main.async {
                completion(.success(movieImage))
            }
        }
    }
}
