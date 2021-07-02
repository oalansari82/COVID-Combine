//
//  PreviewProvider+Extension.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let data = COVIDDataContainer(records: [
        COVIDDataContainer.Records(
            datasetid: "covid-19-cases-in-qatar",
            recordid: "4acecc61feae4c1d4e1c7645a4cda4f14866027c",
            fields: COVIDDataContainer.Records.Fields(
                numberOfNewPositiveCasesInLast24Hrs: 143,
                totalNumberOfDeathsToDate: 588,
                totalNumberOfActiveCasesUndergoingTreatmentToDate: 1707,
                numberOfNewAcuteHospitalAdmissionsInLast24Hrs: 6,
                numberOfNewTestsInLast24Hrs: 20091,
                totalNumberOfVaccineDosesAdministeredInLast24Hrs: 33669,
                totalNumberOfAcuteCasesUnderHospitalTreatment: 101,
                totalNumberOfCasesUnderIcuTreatment: 54,
                numberOfNewIcuAdmissionsInLast24Hrs: 2,
                totalNumberOfVaccineDosesAdministeredSinceStart: "3109044",
                numberOfNewDeathsInLast24Hrs: 0,
                totalNumberOfTestsToDate: 2160754,
                date: "2021-06-29",
                numberOfNewRecoveredCasesInLast24Hrs: 180,
                totalNumberOfRecoveredCasesToDate: 219658,
                totalNumberOfPositiveCasesToDate: 221953),
            recordTimestamp: "2021-06-29T14:28:06.984000+00:00"),
        COVIDDataContainer.Records(
            datasetid: "covid-19-cases-in-qatar",
            recordid: "864dba5f6d8f6ba937ff218eeda8ad76ff4209f6",
            fields: COVIDDataContainer.Records.Fields(
                numberOfNewPositiveCasesInLast24Hrs: 118,
                totalNumberOfDeathsToDate: 588,
                totalNumberOfActiveCasesUndergoingTreatmentToDate: 1744,
                numberOfNewAcuteHospitalAdmissionsInLast24Hrs: 9,
                numberOfNewTestsInLast24Hrs: 19583,
                totalNumberOfVaccineDosesAdministeredInLast24Hrs: 33714,
                totalNumberOfAcuteCasesUnderHospitalTreatment: 99,
                totalNumberOfCasesUnderIcuTreatment: 53,
                numberOfNewIcuAdmissionsInLast24Hrs: 2,
                totalNumberOfVaccineDosesAdministeredSinceStart: "3075375",
                numberOfNewDeathsInLast24Hrs: 0,
                totalNumberOfTestsToDate: 2155430,
                date: "2021-06-28",
                numberOfNewRecoveredCasesInLast24Hrs: 145,
                totalNumberOfRecoveredCasesToDate: 219478,
                totalNumberOfPositiveCasesToDate: 221810),
            recordTimestamp: "2021-06-29T14:28:06.984000+00:00")
        
    ])
    
    
    
}


