//
//  UISprites.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 20.04.2023.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class UISprite: UIView {
    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()
    
    func loadImageWithUrl(_ url: URL) {
        // setup activityIndicator...
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.layer.contents = imageFromCache.cgImage
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                    if self.imageURL == url {
                        self.layer.contents = imageToCache.cgImage
                    }

                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
    
    func clearImg() {
        layer.contents = nil
    }
}
