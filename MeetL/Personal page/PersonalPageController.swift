//
//  AccountInfo.swift
//  MeetL
//
//  Created by Александра Среднева on 2.03.24.
//

import UIKit
import PhotosUI

final class PersonalPageController: UIViewController {
    
    @IBOutlet weak private var personalImage: UIImageView!
    @IBOutlet weak private var editButton: UIButton!
    
    @IBOutlet weak private var personalName: UITextField!
    @IBOutlet weak private var personalAge: UITextField!
    @IBOutlet weak private var personalGender: UITextField!
    @IBOutlet weak private var personalCounrty: UITextField!
    @IBOutlet weak private var personalCity: UITextField!
    @IBOutlet weak private var personalHeight: UITextField!
    @IBOutlet weak private var personalWeight: UITextField!
    @IBOutlet weak private var personalInterests: UITextView!
    @IBOutlet weak private var personalInfo: UITextView!
    
    private let model = PersonalPageViewModel(database: CoreDataService.shared)
    
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet private var textViews: [UITextView]!
    
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

    @IBAction func edit(_ sender: UIButton) {
        model.changeButtonImage(button: sender)

        model.save(nameTextField: personalName,
                   ageTextField: personalAge,
                   genderTextField: personalGender,
                   countryTextField: personalCounrty,
                   cityTextField: personalCity,
                   heightTextField: personalHeight,
                   weightTextField: personalWeight,
                   interestsTextView: personalInterests,
                   aboutTextView: personalInfo,
                   image: personalImage)
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
        openPHPicker(results)
    }
    
    private func openPHPicker(_ results: [PHPickerResult]) {
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
