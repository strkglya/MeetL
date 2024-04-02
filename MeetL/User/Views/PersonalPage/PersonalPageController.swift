//
//  AccountInfo.swift
//  MeetL
//
//  Created by Александра Среднева on 2.03.24.
//

import UIKit
import PhotosUI

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLoadedInfo()
        setUpUi()
    }
    
    private func setUpUi() {
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        personalImage.addGestureRecognizer(imageTapGesture)
        
        personalName.isUserInteractionEnabled = false
        personalImage.layer.cornerRadius = personalImage.frame.width/2
        personalImage.layer.borderWidth = 2
        personalImage.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    private func setUpLoadedInfo(){
        guard let updates = model.loadAccountChangesFromCoreData() else { return }
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
        //модель
        if model.state {
            guard let newUser = createUserFromTextFields() else {return}
            model.saveAccountChangesToCoreData(user: newUser)
        }
        toggleEditing()
    }
    
    func createAlert(){
        let alert = UIAlertController(title: "Error!", message: "All fields must be filled. Fill them or otherwise your changes won't be saved ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func createUserFromTextFields() -> CoreDataModel? {
        var userFromTextFields: CoreDataModel?
        if
            let name = personalName.text,
            let ageText = personalAge.text, let age = Int(ageText),
            let gender = personalGender.text,
            let country = personalCounrty.text,
            let city = personalCity.text,
            let heightText = personalHeight.text, let height = Int(heightText),
            let weightText = personalWeight.text, let weight = Int(weightText),
            let interests = personalInterests.text?.components(separatedBy: ","),
            let about = personalInfo.text,
            let imageData = personalImage.image?.pngData() {
            userFromTextFields = CoreDataModel(id: 0, name: name, age: age, height: height, weight: weight, interests: interests, gender: gender, city: city, country: country, about: about, image: imageData)
        } else {
            createAlert()
        }
        return userFromTextFields
    }
    
    private func toggleEditing(){
        //вьюмодел
        model.state.toggle()
        
        personalName.isUserInteractionEnabled = model.state
        personalAge.isUserInteractionEnabled = model.state
        personalGender.isUserInteractionEnabled = model.state
        personalCounrty.isUserInteractionEnabled = model.state
        personalCity.isUserInteractionEnabled = model.state
        personalHeight.isUserInteractionEnabled = model.state
        personalWeight.isUserInteractionEnabled = model.state
        personalInterests.isUserInteractionEnabled = model.state
        personalInfo.isUserInteractionEnabled = model.state
        personalImage.isUserInteractionEnabled = model.state
        
        let buttonImageName = model.state ? "checkmark.seal.fill" : "pencil"
        
        editButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
        
        toggleBorder()
    }
    
    private func toggleBorder(){
        let editingStyle: UITextField.BorderStyle = model.state ? .roundedRect : .none
        let editingColor: UIColor = model.state ? .white : .clear
        
        personalName.borderStyle = editingStyle
        personalAge.borderStyle = editingStyle
        personalGender.borderStyle = editingStyle
        personalCounrty.borderStyle = editingStyle
        personalCity.borderStyle = editingStyle
        personalHeight.borderStyle = editingStyle
        personalWeight.borderStyle = editingStyle
        personalInterests.backgroundColor = editingColor
        personalInfo.backgroundColor = editingColor
    }
    
    func configureImagePicker(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    
    @objc func pickImage(){
        configureImagePicker()
    }
}


extension PersonalPageController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemprovider = results.first?.itemProvider{
            
            if itemprovider.canLoadObject(ofClass: UIImage.self){
                
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async {
                            self.personalImage.image = selectedImage
                        }
                    }
                }
            }
        }
    }
}
