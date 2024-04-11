import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var customCard: UserCardController!
    @IBOutlet weak private var dismissButton: UIButton!
    @IBOutlet weak private var likeButton: UIButton!
    
    @IBOutlet weak private var chatButton: UIBarButtonItem!
    @IBOutlet weak private var heartButton: UIBarButtonItem!
    @IBOutlet weak private var personalPageButton: UIBarButtonItem!
    
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
    
    private func uploadView() {
        model.imageDidLoad = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.customCard.loadingIndicator.stopAnimating()
                self.customCard.updateImage(image: self.model.loadedImage)
                self.customCard.loadingView.isHidden = true
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
    
    private func like(){
        model.like {
            present(Constants.createAlert(alertTitle: "It's a match!", alertMessage: "It looks like this user liked you back!", actionTitle: "Ok", alertStyle: .default), animated: true)
        }
        uploadView()
    }
    
    private func dislike(){
        model.currentIndex += 1
        uploadView()
    }
    
    @objc private func getDetails(){
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "UserDetails") as! UserDetailsController
        present(secondVC, animated: true)
        guard let loadedUser = model.loadedUser else { return }
        secondVC.configure(model: loadedUser, image: model.loadedImage)
    }
    
    @IBAction func like(_ sender: Any) {
        like()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dislike()
    }
    
    @IBAction func filterPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FilterPage", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "FilterController") as! FilterController
        secondVC.model.delegate = model
        present(secondVC, animated: true)
    }
}

extension ViewController {
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let point = sender.translation(in: view)
        let factor = point.x/view.center.x
        let desiredAngle = 0.61 * factor
        let scale = min(abs(100/abs(point.x)), 1)
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y-65+point.y)
        card.transform = CGAffineTransform(rotationAngle: desiredAngle).scaledBy(x: scale, y: scale)
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                }
                dislike()
                resetCard()
                return
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                }
                like()
                resetCard()
                return
            } else {
                resetCard()
            }
        }
    }
    
    private func resetCard(){
        UIView.animate(withDuration: 0.2) {
            self.customCard.center = CGPoint(x: self.view.center.x, y: self.view.center.y-65)
            self.customCard.transform = CGAffineTransform.identity
        }
    }
}
