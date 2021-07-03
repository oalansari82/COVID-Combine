//
//  HistoricalView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI

struct HistoricalView: View {
    @StateObject var vm = HistoricalViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach(vm.allData.records, id:\.recordid) { record in
                        NavigationLink(
                            destination: HistoricalDetail(item: record.fields)) {
                            HistoricalRowView(record: record.fields)
                        }
                        
                    }
                }
                if vm.isLoading {
                    ProgressView()
                }
            }
        }
        .navigationTitle("Archive")
    }
}

struct HistoricalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoricalView()
        }
    }
}

struct HistoricalRowView: View {
    let record: COVIDDataContainer.Records.Fields
    
    var body: some View {
        LazyVStack {
            HStack {
                HStack(alignment: .top) {
                    Text((record.date ?? "").asAbbreviatedFormat())
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .frame(width: 60)
                        .rotationEffect(Angle(degrees: -90))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 6)
                }

                VStack {
                    Text("\(record.numberOfNewTestsInLast24Hrs ?? 0)")
                    Text("Tested")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("\(record.numberOfNewPositiveCasesInLast24Hrs ?? 0)")
                    Text("Positive")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("\(record.numberOfNewDeathsInLast24Hrs ?? 0)")
                    Text("Death")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.bottom, 4)
        }
    }
}
