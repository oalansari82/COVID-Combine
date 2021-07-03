//
//  ChartView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
    @StateObject var vm: ChartViewModel = ChartViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                chart
                stats
            }
            pickerView
        }
        .navigationTitle("Chart")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarMenu
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChartView()
        }
    }
}

extension ChartView {
    private var chart: some View {
        FilledLineChart(chartData: vm.getChart(numberOfDays: vm.numberOfDays))
            .touchOverlay(chartData: vm.getChart(numberOfDays: vm.numberOfDays), specifier: "%.0f")
            .averageLine(chartData: vm.getChart(numberOfDays: vm.numberOfDays),strokeStyle: StrokeStyle(lineWidth: 1, dash: [5,10]))
            .yAxisGrid(chartData: vm.getChart(numberOfDays: vm.numberOfDays))
            .yAxisLabels(chartData: vm.getChart(numberOfDays: vm.numberOfDays))
            .infoBox(chartData: vm.getChart(numberOfDays: vm.numberOfDays))
            .floatingInfoBox(chartData: vm.getChart(numberOfDays: vm.numberOfDays))
            .headerBox(chartData: vm.getChart(numberOfDays: vm.numberOfDays))
            .legends(chartData: vm.getChart(numberOfDays: vm.numberOfDays), columns: [GridItem(.flexible()), GridItem(.flexible())])
            .id(vm.getChart(numberOfDays: vm.numberOfDays).id)
            .frame(minWidth: 150, maxWidth: 900, minHeight: 300, idealHeight: 350, maxHeight: 400, alignment: .center)
            .padding()
    }
    
    private var stats: some View {
        GroupBox(label:
                    HStack(alignment: .top) {
                        Text(vm.dataField.englishTitle)
                        Spacer()
                        Text(vm.dataField.arabicTitle)
                            .multilineTextAlignment(.trailing)
                    }
                    .font(.subheadline)
                    
        ) {
            HStack {
                Spacer()
                VStack {
                    Text("\(vm.minPoint)")
                        .font(.title)
                    Text("Min أقل")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("\(vm.maxPoint)")
                        .font(.title)
                    Text("Max أكثر")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("\(vm.latestPoint)")
                        .font(.title)
                    Text("Latest الأحدث")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal)
    }
    
    private var pickerView: some View {
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
    
    private var toolbarMenu: some View {
        Menu {
            Button("Positive Cases") {
                vm.dataField = .numberOfNewPositiveCasesInLast24Hrs
                vm.getStats()
            }
            Button("Death Cases") {
                vm.dataField = .numberOfNewDeathsInLast24Hrs
                vm.getStats()
            }
            Button("Current ICU Cases") {
                vm.dataField = .totalNumberOfCasesUnderIcuTreatment
                vm.getStats()
            }
            Button("Current Active") {
                vm.dataField = .totalNumberOfActiveCasesUndergoingTreatmentToDate
                vm.getStats()
            }
            Button("Current Hospitalized") {
                vm.dataField = .totalNumberOfAcuteCasesUnderHospitalTreatment
                vm.getStats()
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
}
