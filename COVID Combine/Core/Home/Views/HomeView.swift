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
        ScrollView {
            Text((vm.latestDay.date ?? "").asAbbreviatedFormat())
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                
                StatItemView(number: Int(vm.latestDay.totalNumberOfVaccineDosesAdministeredSinceStart ?? ""), field: .totalNumberOfVaccineDosesAdministeredSinceStart)
                
                StatItemView(number: vm.latestDay.totalNumberOfVaccineDosesAdministeredInLast24Hrs, field: .totalNumberOfVaccineDosesAdministeredInLast24Hrs)
                
                StatItemView(number: vm.latestDay.totalNumberOfActiveCasesUndergoingTreatmentToDate, field: .totalNumberOfActiveCasesUndergoingTreatmentToDate)
                
                StatItemView(number: vm.latestDay.numberOfNewPositiveCasesInLast24Hrs, field: .numberOfNewPositiveCasesInLast24Hrs)
                
                StatItemView(number: vm.latestDay.totalNumberOfRecoveredCasesToDate, field: .totalNumberOfRecoveredCasesToDate)
                
                StatItemView(number: vm.latestDay.numberOfNewRecoveredCasesInLast24Hrs, field: .numberOfNewRecoveredCasesInLast24Hrs)
                
            })
        }
        .navigationBarTitle("Latest Stats")
    }
}

struct HomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}

struct StatItemView: View {
    let number: Int?
    let field: DataField
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("\(number ?? 0)")
                    .font(.title)
                    .bold()
                Image(systemName: "arrow.up.circle.fill")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            VStack(spacing: 5) {
                Text(field.englishTitle)
                    .multilineTextAlignment(.leading)
                Text(field.arabicTitle)
                    .multilineTextAlignment(.trailing)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        
    }
}
