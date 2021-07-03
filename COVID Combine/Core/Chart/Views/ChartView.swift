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
        ZStack {
            VStack {
                ScrollView {
                    chart
                    stats
                        .redacted(reason: vm.isLoading ? .placeholder : [])
                }
                pickerView
            }
            if vm.isLoading  {
                ProgressView()
            }
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
        FilledLineChart(chartData: vm.getChart())
            .touchOverlay(chartData: vm.getChart(), specifier: "%.0f")
            .averageLine(chartData: vm.getChart(),strokeStyle: StrokeStyle(lineWidth: 1, dash: [5,10]))
            .yAxisGrid(chartData: vm.getChart())
            .yAxisLabels(chartData: vm.getChart())
            .infoBox(chartData: vm.getChart())
            .floatingInfoBox(chartData: vm.getChart())
            .headerBox(chartData: vm.getChart())
            .legends(chartData: vm.getChart(), columns: [GridItem(.flexible())])
            .id(vm.getChart().id)
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
                    .font(.caption)
        ) {
            HStack {
                Spacer()
                stat("Min أقل", value: vm.minPoint)
                Spacer()
                stat("Max أكثر", value: vm.maxPoint)
                Spacer()
                stat("Latest الأحدث", value: vm.latestPoint)
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal)
    }
    
    private func stat(_ text: String, value: Int) -> VStack<TupleView<(Text, Text)>> {
        return VStack {
            Text("\(value)")
                .font(.title)
            Text("\(text)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private func statValue(_ value: Int) -> Text {
        return Text("\(value)")
            .font(.title)
    }
    
    private func statLabel(_ text: String) -> Text {
        return Text(text)
            .font(.caption)
            .foregroundColor(.secondary)
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
            vm.filterData()
        }
    }
    
    private var toolbarMenu: some View {
        Menu {
            Button("Positive Cases") {
                withAnimation(.linear) {
                    vm.dataField = .numberOfNewPositiveCasesInLast24Hrs
                    vm.getStats()
                }
            }
            Button("Death Cases") {
                withAnimation(.linear) {
                    vm.dataField = .numberOfNewDeathsInLast24Hrs
                    vm.getStats()
                }
            }
            Button("Current ICU Cases") {
                withAnimation(.linear) {
                    vm.dataField = .totalNumberOfCasesUnderIcuTreatment
                    vm.getStats()
                }
            }
            Button("Current Active") {
                withAnimation(.linear) {
                    vm.dataField = .totalNumberOfActiveCasesUndergoingTreatmentToDate
                    vm.getStats()
                }
            }
            Button("Current Hospitalized") {
                withAnimation(.linear) {
                    vm.dataField = .totalNumberOfAcuteCasesUnderHospitalTreatment
                    vm.getStats()
                }
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
                .font(.title3)
        }
    }
}
