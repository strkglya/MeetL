import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var customCard: UserCard!
    @IBOutlet weak private var dismissButton: UIButton!
    @IBOutlet weak private var likeButton: UIButton!
    
    @IBOutlet weak private var chatButton: UIBarButtonItem!
    @IBOutlet weak private var heartButton: UIBarButtonItem!
    @IBOutlet weak private var personalPageButton: UIBarButtonItem!
    
    private var model: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        model.loadAllFromJson()
        setUpBorders()
        setUpShadow()
        setUpTaps()
        uploadView()
    }
    
    private func setUpShadow(){
        customCard.layer.shadowColor = UIColor.black.cgColor
        customCard.layer.shadowOpacity = 0.5
        customCard.layer.shadowOffset = CGSize(width: 3, height: 3)
        customCard.layer.shadowRadius = 1
        customCard.layer.masksToBounds = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateShadowPath()
    }

    private func updateShadowPath() {
        customCard.layer.shadowPath = UIBezierPath(roundedRect: customCard.bounds,
                                                    cornerRadius: customCard.layer.cornerRadius).cgPath
    }
    
    private func bind(){
        let loadingService = UserLoadService()
        let imageTransformer = ImageTransformService()
        model = UserViewModel(loadService: loadingService, imageTransformer: imageTransformer, saver: CoreDataService.shared)
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
                self.customCard.updateImage(image: self.model.loadedImage)
                self.customCard.stopLoadingIndicator()
            }
        }
        
        model.userDidChange = { [weak self] in
            guard let self = self else {return}
            guard let user = self.model.loadedUser else {
                present(Constants.createAlert(alertTitle: Errors.simpleError.rawValue, alertMessage: AlertAttributes.noMatches.rawValue, actionTitle: AlertAttributes.ok.rawValue, alertStyle: .default), animated: true)
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
            present(Constants.createAlert(alertTitle: AlertAttributes.match.rawValue, alertMessage: AlertAttributes.matchMessage.rawValue, actionTitle: AlertAttributes.ok.rawValue, alertStyle: .default), animated: true)
        }
        uploadView()
    }
    
    private func dislike(){
        model.currentIndex += 1
        uploadView()
    }
    
    @objc private func getDetails(){
        let storyboard = UIStoryboard(name: StoryboardName.userDetails.rawValue, bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: StoryboardIdentifier.userDetails.rawValue) as! UserDetailsController
        present(secondVC, animated: true)
        guard let loadedUser = model.loadedUser else { return }
        secondVC.configure(model: loadedUser, image: model.loadedImage)
    }
    
    @IBAction private func likeAction() {
        like()
    }
    
    @IBAction private func dislikeAction() {
        dislike()
    }
    
    @IBAction private func filterPage() {
        let storyboard = UIStoryboard(name: StoryboardName.filterPage.rawValue, bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: StoryboardIdentifier.filterPage.rawValue) as! FilterController
        secondVC.model.delegate = model
        present(secondVC, animated: true)
    }
}

extension ViewController {
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let point = sender.translation(in: view)

        rotate(card: card, point: point)
       
        if sender.state == UIGestureRecognizer.State.ended {
            swipeDetected(for: card)
        }
    }
    
    private func rotate(card: UIView, point: CGPoint){
        let scale = min(abs(100/abs(point.x)), 1)
        let factor = point.x/view.center.x
        let desiredAngle = 0.61 * factor
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y-65+point.y)
        card.transform = CGAffineTransform(rotationAngle: desiredAngle).scaledBy(x: scale, y: scale)
    }
    
    private func swipeDetected(for card: UIView){
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
    
    private func resetCard(){
        UIView.animate(withDuration: 0.2) {
            self.customCard.center = CGPoint(x: self.view.center.x, y: self.view.center.y-65)
            self.customCard.transform = CGAffineTransform.identity
        }
    }
}
