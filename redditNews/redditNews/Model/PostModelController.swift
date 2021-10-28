//
//  PostModelController.swift
//  redditNews
//
//  Created by Anastasia Burak on 27.10.21.
//

import Foundation

class PostController {
    
    static let shared = PostController()
    var redditData : [RedditData] = []
    let redditUrl = "https://www.reddit.com/r/dog.json"
    
    func getReddit(searchTerm : String, completion : @escaping ((Bool)->Void) ) {
        let newURL = redditUrl.replacingOccurrences(of: "dog", with: searchTerm)
        
        guard let url = URL(string: newURL) else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) {  (data, _, error) in
            guard let data = data else { completion(false); return }
            
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            let decoder = JSONDecoder()
            
            guard  let arrayOFReddits = try? decoder.decode(JSONData.self , from: data) else { completion(false); return }
            self.redditData = arrayOFReddits.data.children.map({$0.data})
            completion(true)
        }
        dataTask.resume()
    }
}

