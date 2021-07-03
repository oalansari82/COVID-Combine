//
//  ChartViewModel.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI
import Combine
import SwiftUICharts

class ChartViewModel: ObservableObject {
    
    @Published var numberOfDays: Int = 30
    @Published var dataField: DataField = .numberOfNewPositiveCasesInLast24Hrs
    @Published var minPoint = 0
    @Published var maxPoint = 0
    @Published var latestPoint = 0
    @Published var isLoading: Bool = false
    
    private var allData: COVIDDataContainer = COVIDDataContainer(records: [])
    @Published var filteredData: [COVIDDataContainer.Records] = []
    
    private var covidDataService: CovidDataService = CovidDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoading = true
        addSubscribers()
    }
    
    private func addSubscribers() {
        covidDataService.$allCovidData
            .sink { [weak self] returnedData in
                self?.allData = returnedData
                self?.filterData()
                self?.getStats()
                if !returnedData.records.isEmpty {
                    self?.isLoading = false                    
                }
            }
            .store(in: &cancellables)
    }
    
    func filterData() {
        if numberOfDays == -1 {
            self.filteredData = allData.records
        } else {
            let slice = allData.records.prefix(numberOfDays)
            filteredData = Array(slice)
        }
        self.getStats()
    }
    
    
    func getStats() {
        var numbers: [Int] = []
        switch dataField {
        case .numberOfNewPositiveCasesInLast24Hrs:
            filteredData.forEach { record in
                numbers.append(record.fields.numberOfNewPositiveCasesInLast24Hrs ?? 0)
            }
        case .numberOfNewDeathsInLast24Hrs:
            filteredData.forEach { record in
                numbers.append(record.fields.numberOfNewDeathsInLast24Hrs ?? 0)
            }
        case .totalNumberOfCasesUnderIcuTreatment:
            filteredData.forEach { record in
                numbers.append(record.fields.totalNumberOfCasesUnderIcuTreatment ?? 0)
            }
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            filteredData.forEach { record in
                numbers.append(record.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate ?? 0)
            }
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            filteredData.forEach { record in
                numbers.append(record.fields.totalNumberOfAcuteCasesUnderHospitalTreatment ?? 0)
            }
        default:
            break
        }
        minPoint = numbers.min() ?? 0
        maxPoint = numbers.max() ?? 0
        latestPoint = numbers.first ?? 0
    }
    
    func getChart() -> LineChartData {
        var data = LineDataSet(
            dataPoints: [],
            legendTitle: "",
            pointStyle: PointStyle(),
            style: lineStyle())

        var dataPoint = LineChartDataPoint(value: 0)
        
        for day in filteredData {
            let value = getChartDataPoints(for: day, dataField: dataField)
            dataPoint = LineChartDataPoint(value: value, xAxisLabel: day.fields.date, description: day.fields.date)
            data.legendTitle = dataField.englishTitle
            data.dataPoints.append(dataPoint)
        }
        
        return LineChartData(dataSets: data, metadata: chartMetadata(dataField: dataField), chartStyle: chartStyle())
    }
    
    private func getChartDataPoints(for day: COVIDDataContainer.Records, dataField: DataField) -> Double {
        var value: Double = 0
        switch dataField {
        case .numberOfNewPositiveCasesInLast24Hrs:
            if let number = day.fields.numberOfNewPositiveCasesInLast24Hrs {
                value = Double(number)
            }
        case .numberOfNewDeathsInLast24Hrs:
            if let number = day.fields.numberOfNewDeathsInLast24Hrs {
                value = Double(number)
            }
        case .totalNumberOfCasesUnderIcuTreatment:
            if let number = day.fields.totalNumberOfCasesUnderIcuTreatment {
                value = Double(number)
            }
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            if let number = day.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate {
                value = Double(number)
            }
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            if let number = day.fields.totalNumberOfAcuteCasesUnderHospitalTreatment {
                value = Double(number)
            }
        default:
            value = 0
        }
        return value
    }
    
    private func chartMetadata(dataField: DataField) -> ChartMetadata {
        return ChartMetadata(title: dataField.englishTitle, subtitle: dataField.arabicTitle)
    }
    
    private func chartStyle() -> LineChartStyle {
        return LineChartStyle(infoBoxPlacement    : .infoBox(isStatic: false),
                              infoBoxBorderColour : Color.primary,
                              infoBoxBorderStyle  : StrokeStyle(lineWidth: 0.5),
                              
                              markerType          : .indicator(style: DotStyle(size: 10, fillColour: Color.theme.maroon, lineColour: .clear, lineWidth: 0)),
                                                            
                              baseline            : .minimumWithMaximum(of: 0),
                              
                              globalAnimation     : .easeInOut(duration: 0.5)
        )
    }
    
    private func lineStyle() -> LineStyle {
        return LineStyle(lineColour: ColourStyle(colours: [Color.red, Color.theme.maroon.opacity(0.5)], startPoint: .top, endPoint: .bottom), lineType: .curvedLine)
    }
    
}
