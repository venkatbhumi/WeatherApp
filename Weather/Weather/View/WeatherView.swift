//
//  WeatherView.swift
//  Weather
//
//  Created by Anil Reddy on 21/08/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.weatherDetails?.name.capitalized ?? "")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .bold))
            
            Text("\((viewModel.weatherDetails?.dt ?? 0).convertToFormat())")
                .foregroundColor(Color.white)
                .font(.system(size: 15, weight: .light))
                .padding(.bottom,20)

            Text(
                "Average Temperature: \(Int(viewModel.weatherDetails?.main?.temp ?? 0))° C")
                .foregroundColor(Color.white)
                .font(.subheadline)
            
            Text("Pressure: \(viewModel.weatherDetails?.main?.pressure ?? 0) hPa")
                .foregroundColor(Color.white)
                .font(.subheadline)
            
            Text("Humidity: \(viewModel.weatherDetails?.main?.humidity ?? 0)%")
                .foregroundColor(Color.white)
                .font(.subheadline)
                .padding(.bottom,20)
            HStack(spacing: 30){
                VStack(alignment: .leading,spacing:5){
                    Text("\((viewModel.weatherDetails?.weather.first?.description ?? "").uppercased())")
                        .foregroundColor(Color.white)
                        .font(.title3)
                        
                    Text("Feels Like: \(Int(viewModel.weatherDetails?.main?.feelsLike ?? 0))° C")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                    
                    Text("Visibility: \((viewModel.weatherDetails?.visibility ?? 0)/1000) km")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .padding(.bottom,25)
                     
                    .foregroundColor(Color.blue)

                }
            }
            Spacer(minLength:200)
        }
    }
}

#Preview {
    WeatherView()
}
