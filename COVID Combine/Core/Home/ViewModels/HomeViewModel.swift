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
    @Published var isLoading: Bool = false
    private let covidDataService = CovidLastTwoDaysDataService()
    
    private var lastTwoDays: [COVIDDataContainer.Records]?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        covidDataService.$lastTwoDaysCovidData
            .sink { [weak self] returnedLatestDay in
                self?.latestDay = self?.getLatestDayData(data: returnedLatestDay) ?? COVIDDataContainer.Records.Fields()
                self?.lastTwoDays = returnedLatestDay.records
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    private func getLatestDayData(data: COVIDDataContainer) -> COVIDDataContainer.Records.Fields {
        return data.records.first?.fields ?? COVIDDataContainer.Records.Fields()
    }
    
    func reloadData() {
        isLoading = true
        covidDataService.getData()
    }
    
    func checkIfNumberIsIncreasing(dataField: DataField) -> UpOrDown {
        var upOrDown: UpOrDown = .none
        
        switch dataField {
        case .numberOfNewPositiveCasesInLast24Hrs:
            if let yesterday = lastTwoDays?.first?.fields.numberOfNewPositiveCasesInLast24Hrs,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.numberOfNewPositiveCasesInLast24Hrs {
                upOrDown = self.upOrDown(lhs: yesterday, rhs: dayBeforeYesterday)
            }
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            if let yesterday = lastTwoDays?.first?.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate {
                upOrDown = self.upOrDown(lhs: yesterday, rhs: dayBeforeYesterday)
            }
        case .numberOfNewTestsInLast24Hrs:
            if let yesterday = lastTwoDays?.first?.fields.numberOfNewTestsInLast24Hrs,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.numberOfNewTestsInLast24Hrs {
                upOrDown = self.upOrDown(lhs: yesterday, rhs: dayBeforeYesterday)
            }
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            if let yesterday = lastTwoDays?.first?.fields.totalNumberOfAcuteCasesUnderHospitalTreatment,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.totalNumberOfAcuteCasesUnderHospitalTreatment {
                upOrDown = self.upOrDown(lhs: yesterday, rhs: dayBeforeYesterday)
            }
        case .totalNumberOfCasesUnderIcuTreatment:
            if let yesterday = lastTwoDays?.first?.fields.totalNumberOfCasesUnderIcuTreatment,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.totalNumberOfCasesUnderIcuTreatment {
                upOrDown = self.upOrDown(lhs: yesterday, rhs: dayBeforeYesterday)
            }
        case .numberOfNewDeathsInLast24Hrs:
            if let yesterday = lastTwoDays?.first?.fields.numberOfNewDeathsInLast24Hrs,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.numberOfNewDeathsInLast24Hrs {
                upOrDown = self.upOrDown(lhs: yesterday, rhs: dayBeforeYesterday)
            }
        default:
            upOrDown = .none
        }
        
        return upOrDown
    }
    
    private func upOrDown(lhs: Int, rhs: Int) -> UpOrDown {
        if lhs > rhs {
            return .up
        } else if lhs < rhs {
            return .down
        } else {
            return .equal
        }
    }
}
