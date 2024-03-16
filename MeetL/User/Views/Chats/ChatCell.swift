//
//  ChatCell.swift
//  MeetL
//
//  Created by Александра Среднева on 5.03.24.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var likedImage: UIImageView!
    @IBOutlet weak var likedName: UILabel!
    @IBOutlet weak var likedAge: UILabel!
    @IBOutlet weak var likedAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(model: CoreDataModel){
        likedImage.image = UIImage(data: model.image)
        likedName.text = model.name
        likedAge.text = String(model.age)
        likedAddress.text = "\(model.address)"
    }
}
