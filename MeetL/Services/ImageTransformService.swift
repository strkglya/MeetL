//
//  ImageTransformer.swift
//  MeetL
//
//  Created by Александра Среднева on 14.04.24.
//

import UIKit

protocol ImageTransformer {
    func imageFromUrl(urlString: String, completion: @escaping (UIImage?) -> Void)
}

final class ImageTransformService: ImageTransformer {
    
     func imageFromUrl(urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let imageURL = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                guard error == nil, let data = data, let image = UIImage(data: data) else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                completion(image)
            }.resume()
        }
}
