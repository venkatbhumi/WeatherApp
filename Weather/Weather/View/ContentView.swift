//
//  ContentView.swift
//  Weather
//
//  Created by Anil Reddy on 21/08/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State var citySearchText: String = ""
    let locationManager = LocationManager()
    
    var body: some View {
        ZStack() {
            ContainerRelativeShape()
                .fill(Color.blue.gradient)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    SearchBar(text: $citySearchText,
                              placeHolder: "Search by City or Zipcode", viewModel: viewModel)
                    
                    if viewModel.weatherDetails?.name != nil {
                        WeatherView(viewModel: viewModel)
                    } else {
                        Text("🔎 No Search Results.")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
        }.onAppear() {
            locationManager.requestLocation()
            Task {
                viewModel.getWeather(location:"Frisco")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
