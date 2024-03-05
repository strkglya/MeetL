//
//  UserDetails.swift
//  MeetL
//
//  Created by Александра Среднева on 27.02.24.
//

import UIKit

class UserDetails: UIViewController {

    @IBOutlet weak var nameDetails: UILabel!
    @IBOutlet weak var ageDetails: UILabel!
    @IBOutlet weak var heightDetails: UILabel!
    @IBOutlet weak var weightDetails: UILabel!
    @IBOutlet weak var genderDetails: UILabel!
    @IBOutlet weak var interests: UILabel!
    @IBOutlet weak var aboutUser: UILabel!
    @IBOutlet weak var countryDetails: UILabel!
    @IBOutlet weak var cityDetails: UILabel!
    @IBOutlet weak var imageDetails: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetails.layer.cornerRadius = imageDetails.frame.width/2
        imageDetails.layer.borderWidth = 2
        imageDetails.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    func configure(model: UserModel, image: UIImage){
        nameDetails.text = model.name
        ageDetails.text = String(model.age)
        genderDetails.text = model.gender
        heightDetails.text = String(model.height)
        weightDetails.text = String(model.weight)
        interests.text = model.interestsString
        aboutUser.text = model.about
        countryDetails.text = model.country
        cityDetails.text = model.city
        imageDetails.image = image
    }
}
