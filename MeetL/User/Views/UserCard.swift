//
//  UserCard.swift
//  MeetL
//
//  Created by Александра Среднева on 23.02.24.
//

import UIKit

@IBDesignable
class UserCard: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        personImage.layer.borderWidth = 2
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
    
    func configure(name: String?, age: String?, image: UIImage?){
        nameLabel.text = name
        ageLabel.text = age
        personImage.image = image
        personImage.layer.cornerRadius = personImage.frame.width/2
    }
}
