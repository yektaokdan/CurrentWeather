//
//  HomeVM.swift
//  CurrentWeather
//
//  Created by yekta on 29.02.2024.
//
import Foundation

class WeatherViewModel {
    private var weatherService: WebService
    var weather: Weather? {
        didSet {
            self.updateUI?()
        }
    }
    
    var updateUI: (() -> Void)?
    
    init(weatherService: WebService = WebService()) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(forCity city: String) {
        weatherService.fetchWeather(city: city) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.weather = weather
            case .failure(let error):
                print(error)
            }
        }
    }
}
