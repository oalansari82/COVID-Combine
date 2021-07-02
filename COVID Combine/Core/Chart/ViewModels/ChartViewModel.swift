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
    
    @Published var allData: COVIDDataContainer = COVIDDataContainer(records: [])
    
    private var chartDataService: ChartDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(numberOfDays: Int) {
        self.chartDataService = ChartDataService(numberOfDays: numberOfDays)
        addSubscribers()
    }
    
    func reloadData() {
        chartDataService.getData(numberOfDays: self.numberOfDays)
    }
    
    private func addSubscribers() {
        chartDataService.$allCovidData
            .sink { [weak self] returnedData in
                self?.allData = returnedData
            }
            .store(in: &cancellables)
    }
    
    func getChart(for dataField: DataField, numberOfDays: Int) -> LineChartData {
        
        var data = LineDataSet(
            dataPoints: [],
            legendTitle: "Chartty",
            pointStyle: PointStyle(),
            style: LineStyle(lineColour: ColourStyle(colours: [Color.red.opacity(0.50),
                                                               Color.red.opacity(0.00)],
                                                     startPoint: .top,
                                                     endPoint: .bottom),
                             lineType: .line)
        )
        var dataPoint = LineChartDataPoint(value: 0)
        
        for day in allData.records {
            switch dataField {
            case .numberOfNewPositiveCasesInLast24Hrs:
                if let number = day.fields.numberOfNewPositiveCasesInLast24Hrs {
                    let value = Double(number)
                    dataPoint = LineChartDataPoint(value: value, xAxisLabel: day.fields.date, description: day.fields.date)
                }
            default: break
            }
            data.dataPoints.append(dataPoint)
        }
        return LineChartData(dataSets: data,
                             metadata: ChartMetadata(title: dataField.englishTitle, subtitle: dataField.arabicTitle),
                             xAxisLabels: ["Monday", "Thursday", "Sunday"],
                             chartStyle: LineChartStyle(infoBoxPlacement: .header,
                                                        markerType: .full(attachment: .point),
                                                        xAxisLabelsFrom: .chartData(rotation: .degrees(0)),
                                                        baseline: .minimumWithMaximum(of: 5000)))
    }
    
}
