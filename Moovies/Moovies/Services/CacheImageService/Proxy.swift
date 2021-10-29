// Proxy.swift
// Copyright © Vera Malygina. All rights reserved.

import UIKit

protocol LoadImageProtocol {
    func loadImage(url: URL, compleation: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

final class Proxy: LoadImageProtocol {
    // MARK: - Private Properties

    private let imageAPIService: ImageAPIServiceProtocol?
    private let fileManagerService: FileManagerServiceProtocol?

    // MARK: - Initializers

    init(imageAPIService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public methods

    func loadImage(url: URL, compleation: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        let image = fileManagerService?.getImageFromCache(url: url.absoluteString)

        if image == nil {
            imageAPIService?.getImage(imagePath: url.absoluteString) { result in
                switch result {
                case let .success(image):
                    self.fileManagerService?.saveImageToCache(url: url.absoluteString, image: image)
                    compleation(.success(image))
                case let .failure(error):
                    compleation(.failure(error))
                }
            }
        } else {
            guard let image = image else { return }
            compleation(.success(image))
        }
    }
}
