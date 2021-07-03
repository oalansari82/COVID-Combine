//
//  HistoricalDetail.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI

struct HistoricalDetail: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    let item: COVIDDataContainer.Records.Fields
    
    var body: some View {
        ScrollView {
            stats
                .navigationBarTitle((item.date ?? "").asAbbreviatedFormat(), displayMode: .inline)
        }
    }
}

struct HistoricalDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoricalDetail(item: dev.data.records[0].fields)
        }
    }
}

extension HistoricalDetail {
    private var stats: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
            Group {
                Group {
                    StatItemView(number: Int(item.totalNumberOfVaccineDosesAdministeredSinceStart ?? ""), field: .totalNumberOfVaccineDosesAdministeredSinceStart, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.totalNumberOfVaccineDosesAdministeredInLast24Hrs, field: .totalNumberOfVaccineDosesAdministeredInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.totalNumberOfActiveCasesUndergoingTreatmentToDate, field: .totalNumberOfActiveCasesUndergoingTreatmentToDate, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.numberOfNewPositiveCasesInLast24Hrs, field: .numberOfNewPositiveCasesInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.totalNumberOfRecoveredCasesToDate, field: .totalNumberOfRecoveredCasesToDate, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.numberOfNewRecoveredCasesInLast24Hrs, field: .numberOfNewRecoveredCasesInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.totalNumberOfTestsToDate, field: .totalNumberOfTestsToDate, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.numberOfNewTestsInLast24Hrs, field: .numberOfNewTestsInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                }
                
                Group {
                    StatItemView(number: item.totalNumberOfAcuteCasesUnderHospitalTreatment, field: .totalNumberOfAcuteCasesUnderHospitalTreatment, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.numberOfNewAcuteHospitalAdmissionsInLast24Hrs, field: .numberOfNewAcuteHospitalAdmissionsInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.totalNumberOfCasesUnderIcuTreatment, field: .totalNumberOfCasesUnderIcuTreatment, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.numberOfNewIcuAdmissionsInLast24Hrs, field: .numberOfNewIcuAdmissionsInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.totalNumberOfDeathsToDate, field: .totalNumberOfDeathsToDate, upOrDown: .none, backgroundColor: nil)
                    
                    StatItemView(number: item.numberOfNewDeathsInLast24Hrs, field: .numberOfNewDeathsInLast24Hrs, upOrDown: .none, backgroundColor: nil)
                }
            }
        })
    }
}
