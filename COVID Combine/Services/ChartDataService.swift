//
//  ChartDataService.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import Foundation
import Combine

class ChartDataService {
    
    @Published var allCovidData: COVIDDataContainer = COVIDDataContainer(records: [])
    
    var dataSubscription: AnyCancellable?
    
    init(numberOfDays: Int) {
        getData(numberOfDays: numberOfDays)
    }
    
    func getData(numberOfDays: Int) {
        guard let url = URL(string: "https://www.data.gov.qa/api/records/1.0/search/?dataset=covid-19-cases-in-qatar&q=&lang=en&rows=\(numberOfDays)&sort=date&facet=date") else { return }
        
        dataSubscription = NetworkingManager.download(url: url)
            .decode(type: COVIDDataContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedData in
                self?.allCovidData = returnedData
            })
    }
    
}
