//
//  ImageDownloadManager.swift
//  ArticleListAssignmentPG

//  Created by Ajeet Sharma on 1/02/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import UIKit

typealias ImageDownloadCompletion = (_ imageURL: String, _ image: UIImage?) -> ()

class ImageDownloadManager: NSObject{
    
    func loadImage(imageURL: String, completion: ImageDownloadCompletion?) {
            guard let imgURL = URL(string: imageURL) else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imgURL)
        DispatchQueue.global().async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                    completion?(imageURL, image)
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                            completion?(imageURL, image)
                    }
                }).resume()
            }
        }
    }
}
