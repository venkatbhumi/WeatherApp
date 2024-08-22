//
//  DailyWeatherNavigator.swift
//  WeatherApp
//
//  Created by Anil Reddy on 21/08/24.
//

import Foundation
import UIKit
import SwiftUI

protocol MainNavigatorType {
    var window:UIWindow? {
        get
    }
}

extension MainNavigatorType {
    var window:UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
}


protocol DailyWeatherNavigatorType:MainNavigatorType {
    var navigationController: UINavigationController? { get }
    func show()
    func showDetails(weather:Weather)
}


struct DailyWeatherNavigator: DailyWeatherNavigatorType {
    var navigationController: UINavigationController? {
        window?.rootViewController as? UINavigationController
    }
    
    func showDetails(weather: Weather) {
        let view = EmptyView()
        let vc = UIHostingController(rootView: view)
        navigationController?.pushViewController(vc, animated: true)
    }

     func show() {
        let presenter = ContentView()
        let vc = UIHostingController(rootView: presenter)
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
    }
}
