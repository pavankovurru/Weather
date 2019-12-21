
import Foundation

struct WeatherData: Codable {
    let list: [List]
}

struct List: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}


//{
//    "message": "accurate",
//    "cod": "200",
//    "count": 1,
//    "list": [
//        {
//            "id": 2643743,
//            "name": "London",
//            "coord": {
//                "lat": 51.5085,
//                "lon": -0.1258
//            },
//            "main": {
//                "temp": 7,
//                "pressure": 1012,
//                "humidity": 81,
//                "temp_min": 5,
//                "temp_max": 8
//            },
//            "dt": 1485791400,
//            "wind": {
//                "speed": 4.6,
//                "deg": 90
//            },
//            "sys": {
//                "country": "GB"
//            },
//            "rain": null,
//            "snow": null,
//            "clouds": {
//                "all": 90
//            },
//            "weather": [
//                {
//                    "id": 701,
//                    "main": "Mist",
//                    "description": "mist",
//                    "icon": "50d"
//                },
//                {
//                    "id": 300,
//                    "main": "Drizzle",
//                    "description": "light intensity drizzle",
//                    "icon": "09d"
//                }
//            ]
//        }
//    ]
//}
