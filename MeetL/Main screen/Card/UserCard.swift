//
//  UserCard.swift
//  MeetL
//
//  Created by Александра Среднева on 23.02.24.
//

import UIKit

final class UserCard: UIView {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    @IBOutlet weak private var personImage: UIImageView!
    @IBOutlet weak private var loadingView: UIView!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        loadingIndicator.startAnimating()
        personImage.layer.cornerRadius = personImage.frame.width/2
        personImage.layer.borderWidth = 1
        personImage.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        loadingIndicator.startAnimating()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: NibNames.userCard.rawValue, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {fatalError(Errors.nibError.rawValue)}
        view.frame = bounds
        
        addSubview(view)
    }
    
    func configure(user: UserFromJson, image: UIImage?){
        nameLabel.text = user.name
        ageLabel.text = String(user.age)
    }
    
    func updateImage(image: UIImage){
        personImage.image = image
    }
    
    func stopLoadingIndicator(){
        loadingIndicator.stopAnimating()
        loadingView.isHidden = true
    }
}
