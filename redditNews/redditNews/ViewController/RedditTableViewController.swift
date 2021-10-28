//
//  RedditTableViewController.swift
//  redditNews
//
//  Created by Anastasia Burak on 27.10.21.
//

import UIKit

class RedditTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    private var cache: Cache<String, UIImage> = Cache()
    private var photoFetchQueue = OperationQueue()
    private var fetchRequests: [String : FetchPhotoOperation] = [:]
    let postController = PostController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        postController.getReddit(searchTerm: "cat") { (sucess) in
            if sucess {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postController.redditData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RedditTableViewCell
        let post = postController.redditData[indexPath.row]
        
        cell.redditTextView.text = post.title
        loadImage(forCell: cell, forItemAt: indexPath, redditData: post)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    private func loadImage(forCell cell: RedditTableViewCell, forItemAt indexPath: IndexPath, redditData: RedditData) {
        
        if let image = cache[redditData.id] {
            cell.redditImageView?.image = image
        } else {
            //Get Photo
            let operation1 = FetchPhotoOperation(photoRef: redditData)
            //SavePhoto
            let operation2 = BlockOperation {
                guard let image = operation1.image else { return }
                self.cache.cache(value: image, for: redditData.id)
            }
            
            let operation3 = BlockOperation {
                guard let image = operation1.image else { return }
                //if right cell
                if indexPath == self.tableView.indexPath(for: cell) {
                    cell.redditImageView?.image = image
                } else {
                    self.fetchRequests[redditData.id]?.cancel()
                }
            }
            
            operation3.addDependency(operation1)
            operation2.addDependency(operation1)
            OperationQueue.main.addOperation(operation3)
            photoFetchQueue.addOperations([operation1, operation2], waitUntilFinished: false)
            
            fetchRequests[redditData.id] = operation1
        }
        
        
    }
    
    //animation
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 50, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.7, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let post = searchBar.text, !post.isEmpty else { return }
        
        searchBar.resignFirstResponder()
        
        postController.getReddit(searchTerm: post) { (sucess) in
            if sucess {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                
            }
        }
        DispatchQueue.main.async {
            self.searchBar.text = ""
        }
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
    }
    
    
    // MARK: - Navigation
    
    // do preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == cellToDetail {
            let detailVC = segue.destination as! RedditViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let redditData = postController.redditData[indexPath.row]
                detailVC.redditData = redditData
            }
        }
    }
}
