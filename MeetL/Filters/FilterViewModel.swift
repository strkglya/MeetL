//
//  FilterViewModel.swift
//  MeetL
//
//  Created by Александра Среднева on 2.04.24.
//

import Foundation

protocol FilterDelegate: AnyObject {
    func didFinishSelectingFilters(filters: Filter)
}

final class FilterViewModel {
    
    weak var delegate: FilterDelegate?
    
    var filters = Filter() 
  
    func applyFilters(prefferedGender: Dictionary<String, Bool>,
                      buttonStates: Dictionary<String, Bool>,
                      minAge: Int, maxAge: Int,
                      minHeight: Int, maxHeight: Int,
                      minWeight: Int, maxWeight: Int) {
        resetFilters()

        let selectedInterests = buttonStates.filter {$0.value == true}
        let interests = selectedInterests.map{$0.key}
        
        let selectedGenders = prefferedGender.filter {$0.value == true}
        let gender = selectedGenders.map{$0.key}
        
        let filters = Filter(gender: gender, minAge: minAge,
                             maxAge: maxAge,
                             minHeight: minHeight,
                             maxHeight: maxHeight,
                             minWeight: minWeight,
                             maxWeight: maxWeight,
                             interests: interests)
        delegate?.didFinishSelectingFilters(filters: filters)
    }
    
    func resetFilters(){
        self.filters = Filter()
    }
}
