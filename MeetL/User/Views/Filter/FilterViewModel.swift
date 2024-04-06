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

class FilterViewModel {
    
    weak var delegate: FilterDelegate?
    
    private var filters = Filter() 
  
    func applyFilters(buttonStates: Dictionary<String, Bool>,
                      minAge: Int, maxAge: Int,
                      minHeight: Int, maxHeight: Int,
                      minWeight: Int, maxWeight: Int) {
        let selectedInterests = buttonStates.filter {$0.value == true}
        let interests = selectedInterests.map{$0.key}
        let filters = Filter(minAge: minAge,
                             maxAge: maxAge,
                             minHeight: minHeight,
                             maxHeight: maxHeight,
                             minWeight: minWeight,
                             maxWeight: maxWeight,
                             interests: interests)
       // self.filters = filters
        delegate?.didFinishSelectingFilters(filters: filters)
    }
}
