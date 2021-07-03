//
//  HistoricalRowView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI

struct HistoricalRowView: View {
    let record: COVIDDataContainer.Records.Fields
    
    var body: some View {
        LazyVStack {
            HStack {
                dateLabel

                valueAndLabel("Tested", value: record.numberOfNewTestsInLast24Hrs ?? 0)
                Spacer()
                valueAndLabel("Positive", value: record.numberOfNewPositiveCasesInLast24Hrs ?? 0)
                Spacer()
                valueAndLabel("Death", value: record.numberOfNewDeathsInLast24Hrs ?? 0)
                Spacer()
            }
            .padding(.bottom, 4)
        }
    }
}


struct HistoricalRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistoricalRowView(record: dev.data.records[0].fields)
                .previewLayout(.sizeThatFits)
            
            HistoricalRowView(record: dev.data.records[0].fields)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension HistoricalRowView {
    private var dateLabel: some View {
        Text((record.date ?? "").asAbbreviatedFormat())
            .font(.caption2)
            .foregroundColor(.secondary)
            .frame(width: 60)
            .rotationEffect(Angle(degrees: -90))
            .multilineTextAlignment(.center)
            .padding(.vertical, 6)
    }
    
    private func valueAndLabel(_ text: String, value: Int) -> VStack<TupleView<(Text, Text)>> {
        return VStack {
            Text("\(value)")
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
