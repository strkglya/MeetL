//
//  UserCard.swift
//  MeetL
//
//  Created by Александра Среднева on 23.02.24.
//

import UIKit

class UserCardController: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        personImage.layer.cornerRadius = personImage.frame.width/2
        personImage.layer.borderWidth = 1
        personImage.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: "UserCard", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    func configure(user: UserFromJson, image: UIImage?){
        nameLabel.text = user.name
        ageLabel.text = String(user.age)
       
    }
    
    func updateImage(image: UIImage){
        personImage.image = image
    }
    
    func configureFromArray(users: [UserFromJson], image: UIImage) {
        for user in users {
            nameLabel.text = user.name
            ageLabel.text = String(user.age)
        }
    }
}
