//
//  CovidLastTwoDaysDataService.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import Foundation
import Combine

class CovidLastTwoDaysDataService {
    
    @Published var lastTwoDaysCovidData: COVIDDataContainer = COVIDDataContainer(records: [])
    
    var dataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://www.data.gov.qa/api/records/1.0/search/?dataset=covid-19-cases-in-qatar&q=&lang=en&rows=2&sort=date&facet=date") else { return }
        
        dataSubscription = NetworkingManager.download(url: url)
            .decode(type: COVIDDataContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedData in
                self?.lastTwoDaysCovidData = returnedData
            })
    }
    
}
