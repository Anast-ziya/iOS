//
//  Operations.swift
//  redditNews
//
//  Created by Anastasia Burak on 27.10.21.
//

import Foundation
import UIKit

class ConcurrentOperation: Operation {
    
    enum State: String {
        case isReady, isExecuting, isFinished, isFaild
    }
    
    private var _state = State.isReady
    private let stateQueue = DispatchQueue(label: "asta.ParallelStateQueue")
    
    var state: State {
        get {
            var result: State?
            let queue = self.stateQueue
            
            queue.sync {
                result = _state
            }
            
            guard let result = result else { return .isFaild }
            return result
        }
        set {
            let oldValue = state
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: oldValue.rawValue)
            
            stateQueue.sync { self._state = newValue }
            
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: newValue.rawValue)
        }
    }
    
    override  dynamic var isReady: Bool {
        return super.isReady && state == .isReady
    }
    
    override dynamic var isExecuting: Bool {
        return state == .isExecuting
    }
    
    override dynamic var  isFinished: Bool {
        return state == .isFinished
    }
    
    override  var isAsynchronous: Bool {
        return true
    }
    
}

class FetchPhotoOperation: ConcurrentOperation {
    
    var redditData: RedditData
    var image: UIImage?
    private var dataTask: URLSessionDataTask?
    
    init(photoRef: RedditData) {
        self.redditData = photoRef
    }
    
    override func start() {
        state = .isExecuting
        
        guard let url = URL(string: redditData.thumbnail) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            defer { self.state = .isFinished }
            guard let data = data else { return }
            if let downloadedImage = UIImage(data: data) {
                self.image = downloadedImage
            }
        }
        dataTask?.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
    }
    
}
