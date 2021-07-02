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
            .compactMap(getLatestDayData)
            .sink { [weak self] returnedLatestDay in
                self?.latestDay = returnedLatestDay
            }
            .store(in: &cancellables)
    }
    
    private func getLatestDayData(data: COVIDDataContainer) -> COVIDDataContainer.Records.Fields {
        return data.records.first?.fields ?? COVIDDataContainer.Records.Fields()
    }
    
}
