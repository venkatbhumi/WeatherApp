//
//  WeatherApp.swift
//  Weather
//
//  Created by Anil Reddy on 21/08/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    var navigator:DailyWeatherNavigator = DailyWeatherNavigator()
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .onAppear{
                    navigator.show()
            }
        }
    }
}
