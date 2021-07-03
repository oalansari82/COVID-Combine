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
    
    @Published var allData: COVIDDataContainer = COVIDDataContainer(records: [])
    
    private var chartDataService: ChartDataService = ChartDataService(numberOfDays: 30)
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func reloadData() {
        chartDataService.getData(numberOfDays: self.numberOfDays)
    }
    
    private func addSubscribers() {
        chartDataService.$allCovidData
            .sink { [weak self] returnedData in
                self?.allData = returnedData
                self?.getStats()
            }
            .store(in: &cancellables)
    }
    
    
    func getStats() {
        var numbers: [Int] = []
        switch dataField {
        case .numberOfNewPositiveCasesInLast24Hrs:
            allData.records.forEach { record in
                numbers.append(record.fields.numberOfNewPositiveCasesInLast24Hrs ?? 0)
            }
        case .numberOfNewDeathsInLast24Hrs:
            allData.records.forEach { record in
                numbers.append(record.fields.numberOfNewDeathsInLast24Hrs ?? 0)
            }
        case .totalNumberOfCasesUnderIcuTreatment:
            allData.records.forEach { record in
                numbers.append(record.fields.totalNumberOfCasesUnderIcuTreatment ?? 0)
            }
        case .totalNumberOfActiveCasesUndergoingTreatmentToDate:
            allData.records.forEach { record in
                numbers.append(record.fields.totalNumberOfActiveCasesUndergoingTreatmentToDate ?? 0)
            }
        case .totalNumberOfAcuteCasesUnderHospitalTreatment:
            allData.records.forEach { record in
                numbers.append(record.fields.totalNumberOfAcuteCasesUnderHospitalTreatment ?? 0)
            }
        default:
            break
        }
        minPoint = numbers.min() ?? 0
        maxPoint = numbers.max() ?? 0
        latestPoint = numbers.first ?? 0
    }
    
    func getChart(numberOfDays: Int) -> LineChartData {
        var data = LineDataSet(
            dataPoints: [],
            legendTitle: "",
            pointStyle: PointStyle(),
            style: lineStyle())

        var dataPoint = LineChartDataPoint(value: 0)
        
        for day in allData.records {
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
                              
                              markerType          : .vertical(attachment: .line(dot: .style(DotStyle()))),
                                                            
                              baseline            : .minimumWithMaximum(of: 0),
                              
                              globalAnimation     : .easeOut(duration: 1))
    }
    
    private func lineStyle() -> LineStyle {
        return LineStyle(lineColour: ColourStyle(colours: [Color.red, Color.theme.maroon.opacity(0.5)], startPoint: .top, endPoint: .bottom), lineType: .curvedLine)
    }
    
}
