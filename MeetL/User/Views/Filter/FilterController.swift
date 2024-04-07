//
//  FilterController.swift
//  MeetL
//
//  Created by Александра Среднева on 21.03.24.
//

import UIKit
import MultiSlider

class FilterController: UIViewController {
    
    @IBOutlet weak var ageSlider: Slider!
    @IBOutlet weak var heightSlider: Slider!
    @IBOutlet weak var weightSlider: Slider!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    var buttonStates = [String : Bool]()
    var selectedGender = [String : Bool]()
    
    var model = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        
        for button in buttons {
            if let title = button.titleLabel?.text {
                buttonStates[title] = false
            }
        }
        
        selectedGender["Male"] = false
        selectedGender["Female"] = false

    }
    
    private func setUpSliders(){
        ageSlider.valueLabelPosition = .bottom
        ageSlider.valueLabelColor = .black
        
        heightSlider.valueLabelPosition = .bottom
        heightSlider.valueLabelColor = .black
        
        weightSlider.valueLabelPosition = .bottom
        weightSlider.valueLabelColor = .black
    }
    
    @IBAction func interestSelectes(_ sender: UIButton) {
        
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
    
    @IBAction func ageSliderMoved(_ sender: Slider) {
        print(sender.value)
    }
    
    @IBAction func heightSliderMoved(_ sender: Slider) {
        print(sender.value)
    }
    
    @IBAction func weightSliderMoved(_ sender: Slider) {
        print(sender.value)
    }
    
    @IBAction func genderSelected(_ sender: UIButton) {
        //вьюмодель
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
    
    @IBAction func save(_ sender: Any) {
      
        model.applyFilters(prefferedGender: selectedGender, buttonStates: buttonStates,
                           minAge: Int(ageSlider.value[0]), maxAge: Int(ageSlider.value[1]),
                           minHeight: Int(heightSlider.value[0]), maxHeight: Int(heightSlider.value[1]),
                           minWeight: Int(weightSlider.value[0]), maxWeight: Int(weightSlider.value[1]))
 
        dismiss(animated: true)
        }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
