import Foundation
import Alamofire

class WebService {
    func fetchWeather(city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        let apiKey = "4cc07df5dd0fc2fa6ded78a83d329ba3"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        AF.request(url).responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let weather):
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
