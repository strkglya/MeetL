//
//  FilterController.swift
//  MeetL
//
//  Created by Александра Среднева on 21.03.24.
//

import UIKit
import MultiSlider

struct Filter {
    let minAge: Int
    let maxAge: Int
    let minHeight: Int
    let maxHeight: Int
    let minWeight: Int
    let maxWeight: Int
    let interests: [String]
    
    init() {
        self.minAge = 0
        self.maxAge = 0
        self.minHeight = 0
        self.maxHeight = 0
        self.minWeight = 0
        self.maxWeight = 0
        self.interests = []
    }
    
    init(minAge: Int, maxAge: Int, minHeight: Int, maxHeight: Int, minWeight: Int, maxWeight: Int, interests: [String]) {
        self.minAge = minAge
        self.maxAge = maxAge
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.minWeight = minWeight
        self.maxWeight = maxWeight
        self.interests = interests
    }
}

class FilterController: UIViewController {
    
    @IBOutlet weak var ageSlider: Slider!
    @IBOutlet weak var heightSlider: Slider!
    @IBOutlet weak var weightSlider: Slider!
    
    @IBOutlet var buttons: [UIButton]!
    
    var buttonStates = [String: Bool]()
        
    var model: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        
        for button in buttons {
            if let title = button.titleLabel?.text {
                buttonStates[title] = false
            }
        }
    }
    
    private func setUpSliders(){
        ageSlider.valueLabelPosition = .bottom
        ageSlider.valueLabelColor = .black
        
        heightSlider.valueLabelPosition = .bottom
        heightSlider.valueLabelColor = .black
        
        weightSlider.valueLabelPosition = .bottom
        weightSlider.valueLabelColor = .black
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
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
    
    @IBAction func save(_ sender: Any) {
            let selectedInterests = buttonStates.filter {$0.value == true}
            let interests = selectedInterests.map{$0.key}

            let filters = Filter(minAge: Int(ageSlider.value[0]),
                                 maxAge: Int(ageSlider.value[1]),
                                 minHeight: Int(heightSlider.value[0]),
                                 maxHeight: Int(heightSlider.value[1]),
                                 minWeight: Int(weightSlider.value[0]),
                                 maxWeight: Int(weightSlider.value[1]),
                                 interests: interests)
            model?.filters = filters 
            dismiss(animated: true)
        }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
