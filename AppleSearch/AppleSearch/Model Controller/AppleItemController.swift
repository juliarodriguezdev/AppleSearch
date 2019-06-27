//
//  AppleItemController.swift
//  AppleSearch
//
//  Created by Julia Rodriguez on 6/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class AppleItemController {
    
    //https://itunes.apple.com/search?term=nickelback&media=music
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func fetchAppleItemFor(term: String, completion: @escaping ([AppleItem]?) -> Void) {
        guard var url = baseURL else { completion(nil); return}
        
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // term=\(term)
        let searchTermQuery = URLQueryItem(name: "term", value: term)
        //media=music
        let mediaQuery = URLQueryItem(name: "media", value: "music")
    
        // final appending "search?term=\(term)&media=music
        
        components?.queryItems = [searchTermQuery, mediaQuery]
        
        // components.url = final url (all appended components included)
        guard let finalURL = components?.url else { completion(nil); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Oh snap, that search didnt work: \(error)")
                completion(nil)
                return
            }
            guard let data = data else { completion (nil); return }
            
            do {
                let decoder = JSONDecoder()
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: data)
                
                completion(topLevelJSON.results)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
        }.resume()
    }
    
    static func fetchImageFor(appleItem: AppleItem, completion: @escaping (UIImage?) -> Void) {
        
        let url = appleItem.imageURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an image error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Something didn't fetch correctly with the image data")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
