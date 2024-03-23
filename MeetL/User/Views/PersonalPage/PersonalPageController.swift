//
//  AccountInfo.swift
//  MeetL
//
//  Created by Александра Среднева on 2.03.24.
//

import UIKit

class PersonalPageController: UIViewController {

    @IBOutlet weak var personalImage: UIImageView!
    @IBOutlet weak var editButton: UIButton!

    @IBOutlet weak var personalName: UITextField!
    @IBOutlet weak var personalAge: UITextField!
    @IBOutlet weak var personalGender: UITextField!
    @IBOutlet weak var personalCounrty: UITextField!
    @IBOutlet weak var personalCity: UITextField!
    @IBOutlet weak var personalHeight: UITextField!
    @IBOutlet weak var personalWeight: UITextField!
    @IBOutlet weak var personalInterests: UITextView!
    @IBOutlet weak var personalInfo: UITextView!
        
    private let model = UserViewModel()
    
    private var state = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpLoadedInfo()
        setUpUi()
    }
    
    private func setUpUi() {
        personalName.isUserInteractionEnabled = false
        personalImage.layer.cornerRadius = personalImage.frame.width/2
        personalImage.layer.borderWidth = 2
        personalImage.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    private func setUpLoadedInfo(){
        let updates = model.loadAccountChangesFromCoreData()
        personalName.text = updates.name
        personalAge.text = String(updates.age)
        personalGender.text = updates.gender
        personalCounrty.text = updates.country
        personalCity.text = updates.city
        personalHeight.text = String(updates.height)
        personalWeight.text = String(updates.weight)
        personalInterests.text = updates.interestsString
        personalInfo.text = updates.about
        personalImage.image = UIImage(data: updates.image)
    }
    
    @IBAction func edit(_ sender: Any) {
        if state {
            model.saveAccountChangesToCoreData(user: createUserFromTextFields())
            print("saved")
        }
        toggleEditing()
    }
    
    func createUserFromTextFields() -> CoreDataModel {
        guard
            let name = personalName.text,
            let ageText = personalAge.text, let age = Int(ageText),
            let gender = personalGender.text,
            let country = personalCounrty.text,
            let city = personalCity.text,
            let heightText = personalHeight.text, let height = Int(heightText),
            let weightText = personalWeight.text, let weight = Int(weightText),
            let interests = personalInterests.text?.components(separatedBy: ","),
            let about = personalInfo.text,
            let imageData = personalImage.image?.pngData()
        else {
            return CoreDataModel(id: 0, name: "", age: 0, height: 0, weight: 0, interests: [], gender: "", city: "", country: "", about: "", image: Data())
        }

        return CoreDataModel(id: 0, name: name, age: age, height: height, weight: weight, interests: interests, gender: gender, city: city, country: country, about: about, image: imageData)
    }


    
    private func toggleEditing(){
        state.toggle()
        
        personalName.isUserInteractionEnabled = state
        personalAge.isUserInteractionEnabled = state
        personalGender.isUserInteractionEnabled = state
        personalCounrty.isUserInteractionEnabled = state
        personalCity.isUserInteractionEnabled = state
        personalHeight.isUserInteractionEnabled = state
        personalWeight.isUserInteractionEnabled = state
        personalInterests.isUserInteractionEnabled = state
        personalInfo.isUserInteractionEnabled = state
        personalImage.isUserInteractionEnabled = state
        
        let buttonImageName = state ? "checkmark.seal.fill" : "pencil"
       
        editButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
        
        toggleBorder()
    }
    
    private func toggleBorder(){
       
        if state {
            personalName.borderStyle = .roundedRect
            personalAge.borderStyle = .roundedRect
            personalGender.borderStyle = .roundedRect
            personalCounrty.borderStyle = .roundedRect
            personalCity.borderStyle = .roundedRect
            personalHeight.borderStyle = .roundedRect
            personalWeight.borderStyle = .roundedRect
            personalInterests.backgroundColor = .white
            personalInfo.backgroundColor = .white
        } else {
            personalName.borderStyle = .none
            personalAge.borderStyle = .none
            personalGender.borderStyle = .none
            personalCounrty.borderStyle = .none
            personalCity.borderStyle = .none
            personalHeight.borderStyle = .none
            personalWeight.borderStyle = .none
            personalInterests.backgroundColor = .clear
            personalInfo.backgroundColor = .clear
        }
    }
}


