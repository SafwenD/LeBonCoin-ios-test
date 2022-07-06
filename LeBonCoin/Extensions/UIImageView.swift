//
//  UIImageView.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//

import UIKit

extension UIImage {
    static let placeHolder = UIImage(named: "placeHolder")
}

class UIImageDownloaderView: UIImageView {
    
    private var downloadTask: URLSessionTask?
    private func key(forImageUrl url: URL) -> String {
        return url.absoluteString
    }
    
    func load(with url: URL?, placeholder: UIImage? = nil) {
        guard let _url = url else { return }
        if let task = downloadTask {
            task.cancel()
        }
        self.image = placeholder
        let imageKey = key(forImageUrl: _url)
        if let cachedImage = ImageCache.shared.image(forKey: imageKey) {
            self.image = cachedImage
            return
        }
        let task = URLSession.shared.dataTask(with: _url) { [weak self] data, response, error in
            guard let data = data, let downloadedImage = UIImage(data: data) else { return}
            ImageCache.shared.save(image: downloadedImage, forKey: imageKey)
            DispatchQueue.main.async {
                self?.image = downloadedImage
            }
        }
        downloadTask = task
        task.resume()
    }
}

class ImageCache {

    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() {
        // For memory warnings
        NotificationCenter.default.addObserver(self, selector: #selector(clear), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    @objc func clear() {
        self.cache.removeAllObjects()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
