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
                                .redacted(reason: vm.isLoading ? .placeholder : [])
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
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
