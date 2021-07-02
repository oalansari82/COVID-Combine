//
//  HomeView.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import SwiftUI

struct HomeView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ScrollView {
            Text(vm.latestDay.date)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                ForEach(0..<10) { _ in
                    StatItemView()
                }
            })
        }
        .navigationBarTitle("Latest Stats")
    }
}

struct HomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}

struct StatItemView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("3,109,044")
                    .font(.title)
                    .bold()
                Image(systemName: "arrow.up.circle.fill")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            VStack(spacing: 5) {
                Text("Total Vaccine Given")
                    .multilineTextAlignment(.leading)
                Text("إجمالي عدد اللقاحات التي تم إعطائها")
                    .multilineTextAlignment(.trailing)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        
    }
}
