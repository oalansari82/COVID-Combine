//
//  HomeView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import SwiftUI

struct HomeView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                Text((vm.latestDay.date ?? "").asAbbreviatedFormat())
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                stats
            }
            
            if vm.isLoading {
                ProgressView()
            }
        }
        .navigationBarTitle("Latest Stats")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarButton
            }
        }
    }
}

struct HomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}

extension HomeView {
    private var toolbarButton: some View {
        Button(action: {
            vm.reloadData()
        }, label: {
            Image(systemName: "arrow.triangle.2.circlepath")
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
                .animation(.linear(duration: 1))
        })
    }
    private var stats: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
            Group {
                Group {
                    StatItemView(number: Int(vm.latestDay.totalNumberOfVaccineDosesAdministeredSinceStart ?? ""), field: .totalNumberOfVaccineDosesAdministeredSinceStart, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfVaccineDosesAdministeredSinceStart), backgroundColor: Color.theme.maroon)
                    
                    StatItemView(number: vm.latestDay.totalNumberOfVaccineDosesAdministeredInLast24Hrs, field: .totalNumberOfVaccineDosesAdministeredInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfVaccineDosesAdministeredInLast24Hrs), backgroundColor: Color.theme.maroon)
                    
                    StatItemView(number: vm.latestDay.totalNumberOfActiveCasesUndergoingTreatmentToDate, field: .totalNumberOfActiveCasesUndergoingTreatmentToDate, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfActiveCasesUndergoingTreatmentToDate), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.numberOfNewPositiveCasesInLast24Hrs, field: .numberOfNewPositiveCasesInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .numberOfNewPositiveCasesInLast24Hrs), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.totalNumberOfRecoveredCasesToDate, field: .totalNumberOfRecoveredCasesToDate, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfRecoveredCasesToDate), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.numberOfNewRecoveredCasesInLast24Hrs, field: .numberOfNewRecoveredCasesInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .numberOfNewRecoveredCasesInLast24Hrs), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.totalNumberOfTestsToDate, field: .totalNumberOfTestsToDate, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfTestsToDate), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.numberOfNewTestsInLast24Hrs, field: .numberOfNewTestsInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .numberOfNewTestsInLast24Hrs), backgroundColor: nil)
                }
                
                Group {
                    StatItemView(number: vm.latestDay.totalNumberOfAcuteCasesUnderHospitalTreatment, field: .totalNumberOfAcuteCasesUnderHospitalTreatment, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfAcuteCasesUnderHospitalTreatment), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.numberOfNewAcuteHospitalAdmissionsInLast24Hrs, field: .numberOfNewAcuteHospitalAdmissionsInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .numberOfNewAcuteHospitalAdmissionsInLast24Hrs), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.totalNumberOfCasesUnderIcuTreatment, field: .totalNumberOfCasesUnderIcuTreatment, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfCasesUnderIcuTreatment), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.numberOfNewIcuAdmissionsInLast24Hrs, field: .numberOfNewIcuAdmissionsInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .numberOfNewIcuAdmissionsInLast24Hrs), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.totalNumberOfDeathsToDate, field: .totalNumberOfDeathsToDate, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .totalNumberOfDeathsToDate), backgroundColor: nil)
                    
                    StatItemView(number: vm.latestDay.numberOfNewDeathsInLast24Hrs, field: .numberOfNewDeathsInLast24Hrs, upOrDown: vm.checkIfNumberIsIncreasing(dataField: .numberOfNewDeathsInLast24Hrs), backgroundColor: nil)
                }
            }
        })
    }
}
