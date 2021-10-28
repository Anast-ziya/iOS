import UIKit

import PlaygroundSupport

class FirstViewController: UIViewController {
    var button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View Controller 1"
        view.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initButton()
    }
    
    @objc func buttonWasPressed()  {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = UIColor.yellow
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(button)
    }
}

class SecondViewController: UIViewController {
   
    var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View Controller 2"
        view.backgroundColor = UIColor.white
        loadPhoto()
    }
    
    func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        view.addSubview(image)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    func loadPhoto()  {
        if let imageURL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg") {
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                    if let data = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                        self.image.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

let vc = FirstViewController()
let navBar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navBar
