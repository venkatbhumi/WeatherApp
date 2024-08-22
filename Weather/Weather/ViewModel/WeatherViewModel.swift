//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anil Reddy on 19/08/24.
//

import Foundation

class WeatherViewModel : ObservableObject {
    var networkManager = NetworkManager()
    @Published var weatherDetails: WeatherModel?
    
    func getWeather(location: String) {
        let params = ["q":"\(location)", "appid":Constants.apiKey]
        let weatherUrl = createGetURL(baseURL: Constants.baseUrl, params: params)
        networkManager.request(modelType: WeatherModel.self, url: weatherUrl, httpMethod: HttpMethodType.Get) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let weather):
                    self.weatherDetails = weather
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func createGetURL(baseURL: String, params: [String: String]) -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        if let url = urlComponents?.url {
            return url
        } else {
            return nil
        }
    }
}

extension WeatherViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error)
    }

}
