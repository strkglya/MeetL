//
//  UserDetails.swift
//  MeetL
//
//  Created by Александра Среднева on 27.02.24.
//

import UIKit

final class UserDetailsController: UIViewController {

    @IBOutlet weak private var nameDetails: UILabel!
    @IBOutlet weak private var ageDetails: UILabel!
    @IBOutlet weak private var heightDetails: UILabel!
    @IBOutlet weak private var weightDetails: UILabel!
    @IBOutlet weak private var genderDetails: UILabel!
    @IBOutlet weak private var interests: UILabel!
    @IBOutlet weak private var aboutUser: UILabel!
    @IBOutlet weak private var countryDetails: UILabel!
    @IBOutlet weak private var cityDetails: UILabel!
    @IBOutlet weak private var imageDetails: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetails.layer.cornerRadius = imageDetails.frame.width/2
        imageDetails.layer.borderWidth = 2
        imageDetails.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    func configure(model: UserFromJson, image: UIImage){
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
