//
//  HomeViewModel.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var latestDay = COVIDDataContainer.Records.Fields()
    private let covidDataService = CovidDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        covidDataService.$allCovidData
            .map { dataContainer ->  COVIDDataContainer.Records.Fields in
                return dataContainer.records.first?.fields ?? COVIDDataContainer.Records.Fields()
            }
            .sink { [weak self] returnedLatestDay in
                self?.latestDay = returnedLatestDay
            }
            .store(in: &cancellables)
    }
    
}
