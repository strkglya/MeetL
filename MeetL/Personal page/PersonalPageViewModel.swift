//
//  PersonalPageViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 2.04.24.
//

import Foundation
import UIKit

final class PersonalPageViewModel {
    
    private let database: AccountChanged
    
    init(database: AccountChanged){
        self.database = database
    }
    
    private var state = false
    
    private func saveAccountChangesToCoreData(user: UserModel){
        database.saveAccountChanges(updatedInfo: UserModel(id: user.id,
                                                           name: user.name,
                                                           age: user.age,
                                                           height: user.height,
                                                           weight: user.weight,
                                                           interests: user.interests,
                                                           gender: user.gender,
                                                           city: user.city,
                                                           country: user.country,
                                                           about: user.about,
                                                           image: user.image))
    }
    
    func loadAccountChangesFromCoreData() -> UserModel?{
        database.loadAccountChanges()
    }
    
    private func saveToCoreData(user: UserModel) {
        saveAccountChangesToCoreData(user: user)
    }
    
    func save(nameTextField: UITextField,
              ageTextField: UITextField,
              genderTextField: UITextField,
              countryTextField: UITextField,
              cityTextField: UITextField,
              heightTextField: UITextField,
              weightTextField: UITextField,
              interestsTextView: UITextView,
              aboutTextView: UITextView,
              image: UIImageView) {
        if state {
            guard let user = createUserFromTextFields(nameTextField: nameTextField, ageTextField: ageTextField, genderTextField: genderTextField, countryTextField: countryTextField, cityTextField: cityTextField, heightTextField: heightTextField, weightTextField: weightTextField, interestsTextView: interestsTextView, aboutTextView: aboutTextView, image: image) else {return}
            saveToCoreData(user: user)
            toggleUi(textFields: [nameTextField,ageTextField,genderTextField,cityTextField,countryTextField,heightTextField,weightTextField], textViews: [interestsTextView,aboutTextView], image: image)
        } else {
            toggleUi(textFields: [nameTextField,ageTextField,genderTextField,cityTextField,countryTextField,heightTextField,weightTextField], textViews: [interestsTextView,aboutTextView], image: image)
        }
    }
    
    func createUserFromTextFields(nameTextField: UITextField,
                                  ageTextField: UITextField,
                                  genderTextField: UITextField,
                                  countryTextField: UITextField,
                                  cityTextField: UITextField,
                                  heightTextField: UITextField,
                                  weightTextField: UITextField,
                                  interestsTextView: UITextView,
                                  aboutTextView: UITextView,
                                  image: UIImageView) -> UserModel? {
        
        guard let name = nameTextField.text, !name.isEmpty,
              let ageText = ageTextField.text, !ageText.isEmpty,
              let gender = genderTextField.text, !gender.isEmpty,
              let country = countryTextField.text, !country.isEmpty,
              let city = cityTextField.text, !city.isEmpty,
              let heightText = heightTextField.text, !heightText.isEmpty,
              let weightText = weightTextField.text, !weightText.isEmpty,
              let height = Int(heightText),
              let weight = Int(weightText),
              let age = Int(ageText),
              let interests = interestsTextView.text?.components(separatedBy: ","), !interests.isEmpty,
              let about = aboutTextView.text, !about.isEmpty,
              let imageData = image.image?.pngData() else {
            return nil
        }
        
        return UserModel(id: 0, name: name, age: age, height: height, weight: weight, interests: interests, gender: gender, city: city, country: country, about: about, image: imageData)
    }
    
    func changeButtonImage(button: UIButton){
        let image = state ? UIImage(systemName: ImageNames.pencil.rawValue) : UIImage(systemName: ImageNames.checkmark.rawValue)
        button.setImage(image, for: .normal)
    }
    
    private func toggleEditing(textFields: [UITextField], textViews: [UITextView], image: UIImageView){
        state.toggle()
        
        for textField in textFields {
            textField.isUserInteractionEnabled = state
        }
        
        for textView in textViews {
            textView.isUserInteractionEnabled = state
        }
        image.isUserInteractionEnabled = state
    }
    
    private func toggleBorder(textFields: [UITextField], textViews: [UITextView]){
        let editingStyle: UITextField.BorderStyle = state ? .roundedRect : .none
        let editingColor: UIColor = state ? .white : .clear
        
        for textField in textFields {
            textField.borderStyle = editingStyle
        }
        
        for textView in textViews {
            textView.backgroundColor = editingColor
        }
    }
    
    private func toggleUi(textFields: [UITextField], textViews: [UITextView], image: UIImageView){
        toggleEditing(textFields: textFields, textViews: textViews, image: image)
        toggleBorder(textFields: textFields, textViews: textViews)
    }
}
