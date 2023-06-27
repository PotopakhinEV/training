//
//  Weather.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 24.04.2023.
//

import Alamofire

protocol Conditions: Decodable {
    var datetime: String {get}
    var temp: Double {get}
    var icon: String {get}
}

struct VisualCorssingWeather: Decodable {
    let resolvedAddress, address, timezone: String
    let days: [DayConditions]

    static func requestWeather(_ city: String, completionHandler: @escaping (VisualCorssingWeather?, RequestWeatherError?) -> Void) {
        if city.isEmpty {
            completionHandler(nil, RequestWeatherError.badCity)
        }

        let path = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(city)/?key=NG4CMLK4L4TH2G6BSDPZY83RY"
        let request = AF.request(path, method: .get, encoding: JSONEncoding.default)

        request.responseDecodable(of: VisualCorssingWeather.self) { response in
            guard let statusCode = response.response?.statusCode else {
                completionHandler(nil, RequestWeatherError.errorRequest(code: nil))
                return
            }

            switch statusCode {
            case 200:
                guard let dataResponse = response.value else {
                    completionHandler(nil, RequestWeatherError.errorRequest(code: 200))
                    return
                }
                completionHandler(dataResponse, nil)
            default:
                completionHandler(nil, RequestWeatherError.errorRequest(code: statusCode))
                return
            }
        }
    }
}

struct DayConditions: Decodable, Conditions {
    let icon: String
    let datetime: String
    let temp: Double
    let hours: [HoursConditions]
}

struct HoursConditions: Decodable, Conditions {
    let icon: String
    let datetime: String
    let temp: Double
}

enum RequestWeatherError: Error {
    case badCity, errorRequest(code: Int?), unknow

    func getTextError() -> String {
        switch self {
        case .badCity:
            return "Ошибка ввода города"
        case .errorRequest(let code):
            return "Произошла ошибка при запросе данных. Повторите попытку. (Код ответа: \(String(describing: code))"
        case .unknow:
            return "Произошла неизвестная ошибка"
        }
    }
}
