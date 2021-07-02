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
            }
            .store(in: &cancellables)
    }
    
    private func getLatestDayData(data: COVIDDataContainer) -> COVIDDataContainer.Records.Fields {
        return data.records.first?.fields ?? COVIDDataContainer.Records.Fields()
    }
    
    func checkIfNumberIsIncreasing(dataField: DataField) -> UpOrDown {
        var upOrDown: UpOrDown = .none
        
        switch dataField {
        case .numberOfNewPositiveCasesInLast24Hrs:
            if let yesterday = lastTwoDays?.first?.fields.numberOfNewPositiveCasesInLast24Hrs,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.numberOfNewPositiveCasesInLast24Hrs {
                if yesterday > dayBeforeYesterday {
                    upOrDown = .up
                } else if yesterday < dayBeforeYesterday {
                    upOrDown = .down
                } else {
                    upOrDown = .equal
                }
            }
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            if let yesterday = lastTwoDays?.first?.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate {
                if yesterday > dayBeforeYesterday {
                    upOrDown = .up
                } else if yesterday < dayBeforeYesterday {
                    upOrDown = .down
                } else {
                    upOrDown = .equal
                }
            }
        case .numberOfNewTestsInLast24Hrs:
            if let yesterday = lastTwoDays?.first?.fields.numberOfNewTestsInLast24Hrs,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.numberOfNewTestsInLast24Hrs {
                if yesterday > dayBeforeYesterday {
                    upOrDown = .up
                } else if yesterday < dayBeforeYesterday {
                    upOrDown = .down
                } else {
                    upOrDown = .equal
                }
            }
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            if let yesterday = lastTwoDays?.first?.fields.totalNumberOfAcuteCasesUnderHospitalTreatment,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.totalNumberOfAcuteCasesUnderHospitalTreatment {
                if yesterday > dayBeforeYesterday {
                    upOrDown = .up
                } else if yesterday < dayBeforeYesterday {
                    upOrDown = .down
                } else {
                    upOrDown = .equal
                }
            }
        case .totalNumberOfCasesUnderIcuTreatment:
            if let yesterday = lastTwoDays?.first?.fields.totalNumberOfCasesUnderIcuTreatment,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.totalNumberOfCasesUnderIcuTreatment {
                if yesterday > dayBeforeYesterday {
                    upOrDown = .up
                } else if yesterday < dayBeforeYesterday {
                    upOrDown = .down
                } else {
                    upOrDown = .equal
                }
            }
        case .numberOfNewDeathsInLast24Hrs:
            if let yesterday = lastTwoDays?.first?.fields.numberOfNewDeathsInLast24Hrs,
               let dayBeforeYesterday = lastTwoDays?.last?.fields.numberOfNewDeathsInLast24Hrs {
                if yesterday > dayBeforeYesterday {
                    upOrDown = .up
                } else if yesterday < dayBeforeYesterday {
                    upOrDown = .down
                } else {
                    upOrDown = .equal
                }
            }
        default:
            upOrDown = .none
        }
        
        return upOrDown
    }
}
