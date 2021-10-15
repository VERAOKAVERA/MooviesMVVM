// CacheImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import UIKit

protocol CacheImageServiceProtocol {
    func saveImageToCache(url: String, image: UIImage)
    func getImageFromCache(url: String) -> UIImage?
}

/// CacheImageServices
class CacheImageServices: CacheImageServiceProtocol {
    // MARK: - Date

    enum LifeOfCache: Double {
        case days = 2
        case hours = 24
        case minSec = 60
    }

    // MARK: - Private Properties

    private var images = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = LifeOfCache.days.rawValue * LifeOfCache.hours.rawValue * LifeOfCache
        .minSec.rawValue * LifeOfCache.minSec.rawValue

    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(
            for:
            .cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(
            pathName,
            isDirectory:
            true
        )
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    // MARK: - Internal Methods

    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(
                atPath:
                fileName
            ),
            let modificationDate = info[FileAttributeKey.modificationDate] as?
            Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(
            for:
            .cachesDirectory,
            in: .userDomainMask
        ).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(
            CacheImageServices.pathName +
                "/" + hashName
        ).path
    }
}
