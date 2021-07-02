//
//  DataFields.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import Foundation

enum DataField: String, CaseIterable {
    case numberOfNewPositiveCasesInLast24Hrs
    case totalNumberOfDeathsToDate
    case totalNumberOfActiveCasesUndergoingTreatmentToDate
    case numberOfNewAcuteHospitalAdmissionsInLast24Hrs
    case numberOfNewTestsInLast24Hrs
    case totalNumberOfVaccineDosesAdministeredInLast24Hrs
    case totalNumberOfAcuteCasesUnderHospitalTreatment
    case totalNumberOfCasesUnderIcuTreatment
    case numberOfNewIcuAdmissionsInLast24Hrs
    case totalNumberOfVaccineDosesAdministeredSinceStart
    case numberOfNewDeathsInLast24Hrs
    case totalNumberOfTestsToDate
    case date
    case numberOfNewRecoveredCasesInLast24Hrs
    case totalNumberOfRecoveredCasesToDate
    case totalNumberOfPositiveCasesToDate
    
    var englishTitle: String {
        switch self {
        case .numberOfNewPositiveCasesInLast24Hrs:
            return "Positive Cases in 24h"
        case .totalNumberOfDeathsToDate:
            return "Total Deaths to Date"
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            return "Current Active Cases"
        case .numberOfNewAcuteHospitalAdmissionsInLast24Hrs:
            return "Hospitalized in 24h"
        case .numberOfNewTestsInLast24Hrs:
            return "Tests in the last 24h"
        case .totalNumberOfVaccineDosesAdministeredInLast24Hrs:
            return "Total Vaccines in 24h"
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            return "Current Hospitalized"
        case .totalNumberOfCasesUnderIcuTreatment:
            return "Current in ICU"
        case .numberOfNewIcuAdmissionsInLast24Hrs:
            return "ICU Admisions in 24h"
        case .totalNumberOfVaccineDosesAdministeredSinceStart:
            return "Total Vaccines Given"
        case .numberOfNewDeathsInLast24Hrs:
            return "Death Cases in 24h"
        case .totalNumberOfTestsToDate:
            return "Total Tested Cases"
        case .date:
            return "Date"
        case .numberOfNewRecoveredCasesInLast24Hrs:
            return "Recovered Cases in 24h"
        case .totalNumberOfRecoveredCasesToDate:
            return "Total Recovered Cases"
        case .totalNumberOfPositiveCasesToDate:
            return "Total Positive to Date"
        }
    }
    
    var arabicTitle: String {
        switch self {
        case .numberOfNewPositiveCasesInLast24Hrs:
            return "الحالات الجديدة خلال ٢٤ ساعة"
        case .totalNumberOfDeathsToDate:
            return "إجمالي الوفيات"
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            return "إجمالي الحالات النشطة"
        case .numberOfNewAcuteHospitalAdmissionsInLast24Hrs:
            return "الحالات التي تم إدخالها المستشفى خلال ٢٤ ساعة"
        case .numberOfNewTestsInLast24Hrs:
            return "عددالإختبارات خلال ٢٤ ساعة"
        case .totalNumberOfVaccineDosesAdministeredInLast24Hrs:
            return "اللقاحات خلال ٢٤ ساعة"
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            return "عدد الحالات في المستشفى"
        case .totalNumberOfCasesUnderIcuTreatment:
            return "الحالات في العناية المركزة"
        case .numberOfNewIcuAdmissionsInLast24Hrs:
            return "الحالات التي دخلت العناية المركزة خلال ٢٤ ساعة"
        case .totalNumberOfVaccineDosesAdministeredSinceStart:
            return "إجمالي عدد اللقاحات التي تم إعطائها"
        case .numberOfNewDeathsInLast24Hrs:
            return "الوفيات خلال ٢٤ ساعة"
        case .totalNumberOfTestsToDate:
            return "إجمالي الأشخاص الذين تم فحصهم"
        case .date:
            return "تاريخ"
        case .numberOfNewRecoveredCasesInLast24Hrs:
            return "المتعافين خلال ٢٤ ساعة"
        case .totalNumberOfRecoveredCasesToDate:
            return "إجمالي عدد المتعافين"
        case .totalNumberOfPositiveCasesToDate:
            return "إجمالي الحالات الموجبة"
        }
    }
}
