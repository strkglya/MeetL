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
        setUpBorders()
        setUpShadow()
        setUpToolbar()
        setUpTaps()
        uploadView()
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
    }
    
    
    private func setUpToolbar(){
        setUpBarButtonImage(button: chatButton, image: UIImage(named: "chatInactive")!)
        setUpBarButtonImage(button: personalPageButton, image: UIImage(named: "personInactive")!)
    }
    
    private func setUpBarButtonImage(button: UIBarButtonItem, image: UIImage){
        let originalImage = image.withRenderingMode(.alwaysOriginal)
        button.image = originalImage
    }
    
    @objc private func getDetails(){
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "UserDetails") as! UserDetailsController
        present(secondVC, animated: true)
        secondVC.configure(model: model.loadedUser, image: model.loadedImage)
    }
    
    @IBAction func goToChats(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Chats", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ChatsController") as! ChatsController
        present(secondVC, animated: true)
    }
    
    @IBAction func goToPersonalPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PersonalPage", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "PersonalPage")
        present(secondVC, animated: true)
    }
    
    @IBAction func like(_ sender: Any) {
        model.loadFromJson()
        uploadView()
        model.saveToCoreData(likedPerson: model.loadedUser, with: model.loadedImage)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        model.loadFromJson()
        uploadView()
        print("fy")
    }
}
