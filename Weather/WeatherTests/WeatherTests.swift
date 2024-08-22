//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Anil Reddy on 21/08/24.
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockNetworkManager = MockNetworkManager()
        viewModel = WeatherViewModel()
        viewModel.networkManager = mockNetworkManager
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockNetworkManager = nil
    }

    func testGetWeather_Success() {
        // Given
        let expectedWeather = WeatherModel(coord: Coord(lon: -96.8236, lat: 33.1507), weather: [Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], base: "stations", main: nil, visibility: 10000, wind: Wind(speed: 4.47, deg: 347), clouds: Clouds(all: 0), dt: 1724293605, sys: Sys(type: 2, id: 2003174, country: "US", sunrise: 1724241288, sunset: 1724288770), timezone: -18000, id: 4692559, name: "Frisco", cod: 200)
        mockNetworkManager.mockWeatherModel = expectedWeather
        
        let expectation = XCTestExpectation(description: "Weather details should be set")
        
        // When
        viewModel.getWeather(location: "Frisco")
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.weatherDetails?.name, expectedWeather.name)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetWeather_Failure() {
        // Given
        mockNetworkManager.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Weather details should not be set on error")
        
        // When
        viewModel.getWeather(location: "InvalidLocation")
        
        // Then
        DispatchQueue.main.async {
            XCTAssertNil(self.viewModel.weatherDetails)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetWeather_EventHandlerCalledOnSuccess() {
        // Given
        let expectedWeather = WeatherModel(coord: Coord(lon: -96.8236, lat: 33.1507), weather: [Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], base: "stations", main: nil, visibility: 10000, wind: Wind(speed: 4.47, deg: 347), clouds: Clouds(all: 0), dt: 1724293605, sys: Sys(type: 2, id: 2003174, country: "US", sunrise: 1724241288, sunset: 1724288770), timezone: -18000, id: 4692559, name: "Frisco", cod: 200) // Example model initialization
        mockNetworkManager.mockWeatherModel = expectedWeather
        
        let expectation = XCTestExpectation(description: "Event handler should be called")
        
        expectation.fulfill()
         
        // When
        viewModel.getWeather(location: "Frisco")
        
        // Then
        wait(for: [expectation], timeout: 5.0)
    }

    
    func testGetWeather_EventHandlerCalledOnFailure() {
        // Given
        mockNetworkManager.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Event handler should be called on error")
        
        expectation.fulfill()
    
        // When
        viewModel.getWeather(location: "InvalidLocation")
        
        // Then
        wait(for: [expectation], timeout: 5.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
