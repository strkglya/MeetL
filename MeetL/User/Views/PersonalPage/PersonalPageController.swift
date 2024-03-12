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
    @IBOutlet weak var personalJob: UITextField!
    @IBOutlet weak var personalReligion: UITextField!
        
    private var state = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    private func setUpUi() {
        personalName.isUserInteractionEnabled = false
        personalImage.layer.cornerRadius = personalImage.frame.width/2
        personalImage.layer.borderWidth = 2
        personalImage.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
    }
    
    @IBAction func edit(_ sender: Any) {
        toggleEditing()
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
        personalJob.isUserInteractionEnabled = state
        personalReligion.isUserInteractionEnabled = state
        
        let buttonImageName = state ? "checkmark.seal.fill" : "pencil"
        editButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }
}


