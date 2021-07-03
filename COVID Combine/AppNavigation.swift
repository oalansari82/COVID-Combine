//
//  AppNavigation.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/3/21.
//

import SwiftUI

struct AppNavigation: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
                    .tabItem {
                        Label("Home", systemImage: "house")
                }
            .navigationViewStyle(StackNavigationViewStyle())
            
            NavigationView {
                ChartView()
            }
            .tabItem {
                Label("Chart", systemImage: "chart.bar")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            NavigationView {
                HistoricalView()
            }
            .tabItem {
                Label("Archive", systemImage: "clock")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct AppNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigation()
    }
}
