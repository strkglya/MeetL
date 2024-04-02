import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customCard: UserCardController!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var chatButton: UIBarButtonItem!
    @IBOutlet weak var heartButton: UIBarButtonItem!
    @IBOutlet weak var personalPageButton: UIBarButtonItem!
    
    var model: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = UserViewModel()
        model.loadFromJson()
        model.loadAllFromJson()
        setUpBorders()
        setUpShadow()
        setUpTaps()
        uploadView()
        tabBarItem.image = UIImage(named: "heart")
    }
    
    private func setUpShadow(){
        self.customCard.layer.shadowPath =
              UIBezierPath(roundedRect: self.customCard.bounds,
              cornerRadius: self.customCard.layer.cornerRadius).cgPath
        self.customCard.layer.shadowColor = UIColor.black.cgColor
        self.customCard.layer.shadowOpacity = 0.5
        self.customCard.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.customCard.layer.shadowRadius = 1
        self.customCard.layer.masksToBounds = false
    }
    
    private func setUpBorders(){
        customCard.layer.cornerRadius = 80
        customCard.layer.borderWidth = 8
        let color = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
        customCard.layer.borderColor = color.cgColor
    }
    
    private func setUpTaps(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(getDetails))
        customCard.addGestureRecognizer(tap)
    }
    
    func uploadView() {
        model.imageDidLoad = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.customCard.updateImage(image: self.model.loadedImage)
            }
        }
        
        model.userDidChange = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.customCard.configure(user: self.model.loadedUser, image: self.model.loadedImage)
            }
        }
        model.allUsersLoaded = { [weak self] in
            guard let self = self else {return}
        }
    }
    
    private func setUpBarButtonImage(button: UIBarButtonItem, image: UIImage){
        let originalImage = image.withRenderingMode(.alwaysOriginal)
        button.image = originalImage
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "It's a match!", message: "It looks like this user liked you back!", preferredStyle: .alert)

        let action = UIAlertAction(title: "ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func getDetails(){
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "UserDetails") as! UserDetailsController
        present(secondVC, animated: true)
        secondVC.configure(model: model.loadedUser, image: model.loadedImage)
    }
    
    @IBAction func like(_ sender: Any) {
        if model.loadedUser.likedBack {
            showAlert()
            model.saveToCoreData(likedPerson: model.loadedUser, with: model.loadedImage)
        }
        model.loadFromJson()
        uploadView()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        model.loadFromJson()
        uploadView()
        print("fy")
    }
    
    @IBAction func filterPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FilterPage", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "FilterController") as! FilterController
        present(secondVC, animated: true)
    }
}

