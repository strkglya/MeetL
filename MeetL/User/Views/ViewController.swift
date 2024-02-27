import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customCard: UserCard!
    var model: UserViewModel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = UserViewModel()
        model.load()
        setUpBorders()
        setUpShadow()
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
    
    func uploadView() {
        model.userDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.model.imageFromUrl(completion: { image in
                    DispatchQueue.main.async {
                        self?.customCard.configure(name: self?.model.loadedUser.name, age: String(self?.model.loadedUser.age ?? 0), image: image)
                    }
                })
            }
        }
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
