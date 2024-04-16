//
//  ChatCell.swift
//  MeetL
//
//  Created by Александра Среднева on 5.03.24.
//

import UIKit

final class ChatCell: UITableViewCell {

    @IBOutlet weak private var likedImage: UIImageView!
    @IBOutlet weak private var likedName: UILabel!
    @IBOutlet weak private var likedAge: UILabel!
    @IBOutlet weak private var likedAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        likedImage.layer.cornerRadius = likedImage.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(model: UserModel){
        likedImage.image = UIImage(data: model.image)
        likedName.text = model.name
        likedAge.text = String(model.age)
        likedAddress.text = "\(model.address)"
    }
}
