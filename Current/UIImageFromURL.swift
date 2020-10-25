//
//  DownloadUIImage.swift
//  imessage-ext
//
//  Created by Tyler Dakin on 12/20/19.
//  Copyright © 2019 Tyler Dakin. All rights reserved.
//

import Foundation
import UIKit


func getImage(from url: URL) -> UIImage? {
    var returning: UIImage? = nil
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
            returning = image
    }.resume()
    while (returning == nil) {
    }
    
    return returning
}
func getImage(from link: String) -> UIImage? {
    guard link != "https://image.tmdb.org/t/p/original" else { return nil }
    guard let url = URL(string: link) else { return nil }
    return getImage(from: url)
}
