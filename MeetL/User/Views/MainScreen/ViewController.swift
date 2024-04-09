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
        self.customCard.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.customCard.layer.shadowRadius = 1
        self.customCard.layer.masksToBounds = false
    }
    
    private func setUpBorders(){
        customCard.layer.cornerRadius = 30
        customCard.layer.borderWidth = 3
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
            guard let user = self.model.loadedUser else {
                present(Constants.createAlert(alertTitle: "Error", alertMessage: "No matches found", actionTitle: "Ok", alertStyle: .default), animated: true)
                return
            }
            DispatchQueue.main.async {
                self.customCard.configure(user: user, image: self.model.loadedImage)
            }
        }
    }
    
    private func setUpBarButtonImage(button: UIBarButtonItem, image: UIImage){
        let originalImage = image.withRenderingMode(.alwaysOriginal)
        button.image = originalImage
    }
    
    @objc private func getDetails(){
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "UserDetails") as! UserDetailsController
        present(secondVC, animated: true)
        guard let loadedUser = model.loadedUser else { return }
        secondVC.configure(model: loadedUser, image: model.loadedImage)
    }
    
    @IBAction func like(_ sender: Any) {
        model.currentIndex += 1
        guard let loadedUser = model.loadedUser else { return }
        if loadedUser.likedBack {
            present(Constants.createAlert(alertTitle: "It's a match!", alertMessage: "It looks like this user liked you back!", actionTitle: "Ok", alertStyle: .default), animated: true)
            model.saveToCoreData(likedPerson: loadedUser, with: model.loadedImage)
        }
        uploadView()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        model.currentIndex += 1
        if model.currentIndex == model.filteredUsers.count - 1 {
            present(Constants.createAlert(alertTitle: "Oops", alertMessage: "It looks like you ran out of profiles", actionTitle: "Ok :(", alertStyle: .default), animated: true)
            model.currentIndex = 0
        }
        uploadView()
    }
    
    @IBAction func filterPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FilterPage", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "FilterController") as! FilterController
        secondVC.model.delegate = model
        present(secondVC, animated: true)
    }
   
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y-65+point.y)
        
        let xFromCenter = card.center.x - view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended {
            if point.x > 0 {
                model.currentIndex += 1
                guard let loadedUser = model.loadedUser else { return }
                if loadedUser.likedBack {
                    present(Constants.createAlert(alertTitle: "It's a match!", alertMessage: "It looks like this user liked you back!", actionTitle: "Ok", alertStyle: .default), animated: true)
                    model.saveToCoreData(likedPerson: loadedUser, with: model.loadedImage)
                }
                uploadView()
            }
            else if point.x < 0{
                model.currentIndex += 1
                print(xFromCenter)
                if model.currentIndex == model.filteredUsers.count - 1 {
                    present(Constants.createAlert(alertTitle: "Oops", alertMessage: "It looks like you ran out of profiles", actionTitle: "Ok :(", alertStyle: .default), animated: true)
                    model.currentIndex = 0
                }
                uploadView()
            }
        }
    }
    
    
}

