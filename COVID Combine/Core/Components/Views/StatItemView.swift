//
//  StatItemView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import SwiftUI

struct StatItemView: View {
    let number: Int?
    let field: DataField
    let upOrDown: UpOrDown
    let backgroundColor: Color?
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("\(number ?? 0)")
                    .font(.title)
                    .bold()
                    .foregroundColor(backgroundColor == Color.theme.maroon ? .white : .primary)
                if upOrDown != .none {
                    Image(systemName: upOrDown == .up ? "arrow.up.circle.fill" : upOrDown == .down ? "arrow.down.circle.fill" : "equal.circle.fill")
                        .font(.headline)
                        .foregroundColor(upOrDown == .up ? .red : upOrDown == .down ? .green : .orange)
                }
            }
            
            VStack(spacing: 2) {
                Text(field.englishTitle)
                Text(field.arabicTitle)
            }
            .font(.caption)
            .foregroundColor(backgroundColor == Color.theme.maroon ? Color(.systemGray3) : .secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 5)
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(backgroundColor == Color.theme.maroon ? Color.theme.maroon : .clear)
    }
}

struct StatItemView_Previews: PreviewProvider {
    static var previews: some View {
        StatItemView(number: 5003215, field: .numberOfNewPositiveCasesInLast24Hrs, upOrDown: .equal, backgroundColor: nil)
            .previewLayout(.sizeThatFits)
    }
}
