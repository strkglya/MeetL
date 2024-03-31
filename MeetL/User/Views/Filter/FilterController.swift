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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageSlider.valueLabelPosition = .bottom
        ageSlider.valueLabelColor = .black
        
        heightSlider.valueLabelPosition = .bottom
        heightSlider.valueLabelColor = .black
        
        weightSlider.valueLabelPosition = .bottom
        weightSlider.valueLabelColor = .black
    }
    
    @IBAction func ageSliderMoved(_ sender: Slider) {
        print(sender.value)
    }
    @IBAction func heightSliderMoved(_ sender: Any) {
    }
    @IBAction func weightSliderMoved(_ sender: Any) {
    }
}
