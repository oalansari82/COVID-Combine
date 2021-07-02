//
//  ChartView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
    @StateObject var vm = ChartViewModel(numberOfDays: 30)
    
    var body: some View {
        ScrollView {
            FilledLineChart(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays))
                .touchOverlay(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays), specifier: "%.0f")
                .averageLine(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays),strokeStyle: StrokeStyle(lineWidth: 1, dash: [5,10]))
                .yAxisGrid(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays))
                .yAxisLabels(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays))
                .infoBox(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays))
                .floatingInfoBox(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays))
                .headerBox(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays))
                .legends(chartData: vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: vm.numberOfDays), columns: [GridItem(.flexible()), GridItem(.flexible())])
                .id(vm.getChart(for: .numberOfNewPositiveCasesInLast24Hrs, numberOfDays: 90).id)
                .frame(minWidth: 150, maxWidth: 900, minHeight: 300, idealHeight: 350, maxHeight: 400, alignment: .center)
                .padding()
            
            Picker("", selection: $vm.numberOfDays) {
                Text("30 Days").tag(30)
                Text("90 Days").tag(90)
                Text("180 Days").tag(180)
                Text("All").tag(-1)
            }.pickerStyle(SegmentedPickerStyle())
            .padding([.bottom, .horizontal])
            .padding(.bottom, 10)
            .onChange(of: vm.numberOfDays) { (_) in
                vm.reloadData()
            }
        }
        .navigationTitle("Chart")
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChartView()
        }
    }
}
