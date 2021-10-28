//
//  ViewController.swift
//  redditNews
//
//  Created by Anastasia Burak on 27.10.21.
//

import UIKit
import WebKit

class RedditViewController: UIViewController {
    
    @IBOutlet private weak var postWebView: WKWebView!
    var redditData: RedditData? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        let urlString = redditData?.url
        guard let url = URL(string: urlString!) else { return }
        let request = URLRequest(url: url)
        postWebView.load(request)
    }
    
}

