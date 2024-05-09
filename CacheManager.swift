//
//  CacheManager.swift
//  ImageLoaderApp
//
//  Created by Toqsoft on 07/05/24.
//

import Foundation
import UIKit



class ImageCache {
    static let shared = ImageCache()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let diskCacheDirectory: URL
    
    // Dictionary to store URLSessionDataTask for each image URL
    private var imageTasks: [String: URLSessionDataTask] = [:]
    
    private init() {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        diskCacheDirectory = cacheDirectory.appendingPathComponent("ImageCache")
        
        // Create the disk cache directory if it doesn't exist
        try? FileManager.default.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    // Function to fetch image asynchronously
    func fetchImage(withURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        // Check memory cache first
        if let cachedImage = memoryCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        // Cancel previous image loading task for the same URL if exists
        if let task = imageTasks[urlString] {
            task.cancel()
            imageTasks[urlString] = nil
        }
        
        // Check disk cache
        let cachedImagePath = diskCacheDirectory.appendingPathComponent(url.pathComponents[2])
     //   let cachedImagePath = diskCacheDirectory.appendingPathComponent(url.lastPathComponent)
        if let imageData = try? Data(contentsOf: cachedImagePath),
           let cachedImage = UIImage(data: imageData) {
            // Update memory cache
            memoryCache.setObject(cachedImage, forKey: urlString as NSString)
            completion(cachedImage)
            return
        }
        
        // Fetch image from network if not found in cache
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let fetchedImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Save image to memory cache
            self.memoryCache.setObject(fetchedImage, forKey: urlString as NSString)
            
            // Save image to disk cache
            try? data.write(to: cachedImagePath)
            
            completion(fetchedImage)
        }
        
        // Store the URLSessionDataTask associated with the image URL
        imageTasks[urlString] = task
        
        task.resume()
    }
}
