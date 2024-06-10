//
//  ImageCache.swift
//
//  Created by Mohammed Magdy on 4/11/23.
//

import UIKit
protocol ImageCache {
    subscript(_ url:URL) -> UIImage? {get set}
}

struct TempImageCache: ImageCache {
    subscript(url: URL) -> UIImage? {
        get {
            cache.object(forKey: url as NSURL)
        }
        set {
            newValue == nil ? cache.removeObject(forKey: url as NSURL):cache.setObject(newValue ?? #imageLiteral(resourceName: "empty"), forKey: url as NSURL)
        }
    }
    
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
}
