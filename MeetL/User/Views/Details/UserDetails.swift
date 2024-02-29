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
    @IBOutlet weak var genderDetails: UILabel!
    @IBOutlet weak var heightDetails: UILabel!
    @IBOutlet weak var weightDetails: UILabel!
    @IBOutlet weak var jobDetails: UILabel!
    @IBOutlet weak var religionDetails: UILabel!
    @IBOutlet weak var countryDetails: UILabel!
    @IBOutlet weak var cityDetails: UILabel!
    @IBOutlet weak var imageDetails: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(model: UserModel, image: UIImage){
        nameDetails.text = model.name
        ageDetails.text = String(model.age)
        genderDetails.text = model.gender
        heightDetails.text = String(model.height)
        weightDetails.text = String(model.weight)
        jobDetails.text = model.job
        religionDetails.text = model.religion
        countryDetails.text = model.country
        cityDetails.text = model.city
        imageDetails.image = image
        imageDetails.layer.cornerRadius = imageDetails.frame.width/2
    }
}
