//
//  FilterController.swift
//  MeetL
//
//  Created by Александра Среднева on 21.03.24.
//

import UIKit
import MultiSlider

final class FilterController: UIViewController {
    
    @IBOutlet weak private var ageSlider: Slider!
    @IBOutlet weak private var heightSlider: Slider!
    @IBOutlet weak private var weightSlider: Slider!
    
    @IBOutlet weak private var maleButton: UIButton!
    @IBOutlet weak private var femaleButton: UIButton!
    
    @IBOutlet private var buttons: [UIButton]!
    
    private var buttonStates = [String : Bool]()
    private var selectedGender = [String : Bool]()
    
    var model = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        
        for button in buttons {
            if let title = button.titleLabel?.text {
                buttonStates[title] = false
            }
        }
        
        selectedGender[Genders.male.rawValue] = false
        selectedGender[Genders.female.rawValue] = false
    }
    
    private func setUpSliders(){
        ageSlider.valueLabelPosition = .bottom
        ageSlider.valueLabelColor = .black
        
        heightSlider.valueLabelPosition = .bottom
        heightSlider.valueLabelColor = .black
        
        weightSlider.valueLabelPosition = .bottom
        weightSlider.valueLabelColor = .black
    }
    
    @IBAction func interestSelected(_ sender: UIButton) {
        
        guard let title = sender.titleLabel?.text else { return }
        
        buttonStates[title]?.toggle()
        
        if buttonStates[title] == false {
            sender.backgroundColor = .white
            sender.tintColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
            sender.tintColor = .white
        }
    }
    
    @IBAction func genderSelected(_ sender: UIButton) {

        guard let title = sender.titleLabel?.text else { return }
        selectedGender[title]?.toggle()
        
        if selectedGender[title] == false {
            sender.backgroundColor = .white
            sender.tintColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.0431372549, blue: 0.3803921569, alpha: 1)
            sender.tintColor = .white
        }
    }
    
    @IBAction func save() {
        dismiss(animated: true) { [unowned self] in
            model.applyFilters(prefferedGender: selectedGender, buttonStates: buttonStates,
                               minAge: Int(ageSlider.value[0]), maxAge: Int(ageSlider.value[1]),
                               minHeight: Int(heightSlider.value[0]), maxHeight: Int(heightSlider.value[1]),
                               minWeight: Int(weightSlider.value[0]), maxWeight: Int(weightSlider.value[1]))
        }
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
}
