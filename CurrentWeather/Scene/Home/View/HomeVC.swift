//
//  HomeVC.swift
//  CurrentWeather
//
//  Created by yekta on 29.02.2024.
//

import UIKit

class HomeVC: UIViewController, UITextFieldDelegate {
    var weatherViewModel = WeatherViewModel()
    let screenWidth = UIScreen.main.bounds.width
    var sampleTextField = UITextField()
    let cityLabel = UILabel()
    let tempLabel = UILabel()
    let feelsLikeLabel = UILabel()
    let minTempLabel = UILabel()
    let maxTempLabel = UILabel()
    let pressureLabel = UILabel()
    let humidityLabel = UILabel()
    let padding: CGFloat = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // UITextField için yeni bir frame oluştur.
        // Ekranın genişliğine göre UITextField'i ortalar.
        // Yatay kenar boşluklarını 40 (20'er pixel her iki taraftan) olarak ayarla.
        sampleTextField = UITextField(frame: CGRect(x: 20, y: 100, width: screenWidth-40, height: 40))
        
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        
        // Görünümü daha hoş hale getir
        sampleTextField.layer.cornerRadius = 5.0 // Köşeleri yuvarlaklaştır
        sampleTextField.layer.masksToBounds = true
        sampleTextField.layer.borderColor = UIColor.gray.cgColor // Kenarlık rengi
        sampleTextField.layer.borderWidth = 1.0 // Kenarlık kalınlığı
        
        self.view.addSubview(sampleTextField)
        let searchButton = UIButton(frame: CGRect(x: (screenWidth / 4), y: 150, width: screenWidth / 2, height: 40))
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .systemBlue // Butonun arka plan rengini ayarla
        searchButton.setTitleColor(.white, for: .normal) // Butonun yazı rengini ayarla
        searchButton.layer.cornerRadius = 20
        searchButton.layer.masksToBounds = true
        searchButton.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        self.view.addSubview(searchButton)
    
        cityLabel.frame = CGRect(x: 20, y: 200+padding, width: screenWidth - 40, height: 40)
        cityLabel.textAlignment = .center
        view.addSubview(cityLabel)
        
        tempLabel.frame = CGRect(x: 20, y: 220+padding, width: screenWidth - 40, height: 40)
        tempLabel.textAlignment = .center
        view.addSubview(tempLabel)
        
        feelsLikeLabel.frame = CGRect(x: 20, y: 240+padding, width: screenWidth - 40, height: 40)
        feelsLikeLabel.textAlignment = .center
        view.addSubview(feelsLikeLabel)
        
        minTempLabel.frame = CGRect(x: 20, y: 260+padding, width: screenWidth - 40, height: 40)
        minTempLabel.textAlignment = .center
        view.addSubview(minTempLabel)
        
        maxTempLabel.frame = CGRect(x: 20, y: 280+padding, width: screenWidth - 40, height: 40)
        maxTempLabel.textAlignment = .center
        view.addSubview(maxTempLabel)
        
        pressureLabel.frame = CGRect(x: 20, y: 300+padding, width: screenWidth - 40, height: 40)
        pressureLabel.textAlignment = .center
        view.addSubview(pressureLabel)
        
        humidityLabel.frame = CGRect(x: 20, y: 320+padding, width: screenWidth - 40, height: 40)
        humidityLabel.textAlignment = .center
        view.addSubview(humidityLabel)
        
        
        
        
    }
    
    @objc func fetchData(){
        weatherViewModel.fetchWeather(forCity: sampleTextField.text ?? "")
        weatherViewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                if let weather = self?.weatherViewModel.weather {
                    // Burada API'den dönen hava durumu bilgilerini print ediyoruz
                    let city = weather.name
                    let temperature = String(format: "%.2f", weather.main.temp - 273.15) // Kelvin'den Celsius'a çevir
                    let feelLike = String(format: "%.2f", weather.main.feelsLike - 273.15) // Kelvin'den Celsius'a çevir
                    let minTemp = String(format: "%.2f", weather.main.tempMin - 273.15) // Kelvin'den Celsius'a çevir
                    let maxTemp = String(format: "%.2f", weather.main.tempMax - 273.15) // Kelvin'den Celsius'a çevir
                    let pressure = weather.main.pressure
                    let humidity = weather.main.humidity
                    self!.cityLabel.text = "City: \(city)"
                    self!.tempLabel.text = "Temperature: \(temperature)"
                    self!.feelsLikeLabel.text = "Feels Like: \(feelLike)"
                    self!.minTempLabel.text = "Min. Temp: \(minTemp)"
                    self!.maxTempLabel.text = "Max. Temp: \(maxTemp)"
                    self!.pressureLabel.text = "Pressure: \(pressure)"
                    self!.humidityLabel.text = "Humidity: \(humidity)"
                    
                    // Hava durumu açıklaması için
                    if let weatherDescription = weather.weather.first?.description {
                        print("Hava Durumu Açıklaması: \(weatherDescription)")
                    }
                }
            }
        }
    }
    
}
