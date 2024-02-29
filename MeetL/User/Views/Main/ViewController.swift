import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customCard: UserCard!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var model: UserViewModel!

    var loadedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = UserViewModel()
        model.load()
        setUpBorders()
        setUpShadow()
        uploadView()

        let tap = UITapGestureRecognizer(target: self, action: #selector(getDetails))
        customCard.addGestureRecognizer(tap)
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
    
    func uploadView() {
        model.userDidChange = { [weak self] in
                self?.model.imageFromUrl(completion: { image in
                    guard let user = self?.model.loadedUser else {return}
                    guard let image = image else {return}
                    self?.loadedImage = image
                    DispatchQueue.main.async {
                        self?.customCard.configure(user: user, image: self?.loadedImage)
                    }
                })
            
        }
    }
    
    @objc private func getDetails(){
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "UserDetails") as! UserDetails
        present(secondVC, animated: true)
        secondVC.configure(model: model.loadedUser, image: loadedImage)
    }
    
    @IBAction func like(_ sender: Any) {
        model.load()
        uploadView()
        print("Like!!!")
    }
    
    @IBAction func dismiss(_ sender: Any) {
        model.load()
        uploadView()
        print("fy")
    }
}
