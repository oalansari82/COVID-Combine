//
//  HistoricalViewModel.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import Foundation
import Combine

class HistoricalViewModel: ObservableObject {
    
    @Published var allData = COVIDDataContainer(records: [])
    @Published var isLoading: Bool = false
    
    private var covidDataService = CovidDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoading.toggle()
        addSubscribers()
    }
    
    func addSubscribers() {
        covidDataService.$allCovidData
            .sink { [weak self] returnedData in
                self?.allData = returnedData
                if !returnedData.records.isEmpty {
                    self?.isLoading.toggle()
                }
            }
            .store(in: &cancellables)
    }
    
}
