//
//  MockNetworkManager.swift
//  Weather
//
//  Created by Anil Reddy on 21/08/24.
//

import Foundation

class MockNetworkManager: NetworkManager {
    var shouldReturnError = false
    var mockWeatherModel: WeatherModel?
    
    func request<T>(modelType: T.Type, url: URL?, httpMethod: HttpMethodType, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 404, userInfo: nil)))
        } else {
            if let mockWeatherModel = mockWeatherModel as? T {
                completion(.success(mockWeatherModel))
            }
        }
    }
}
