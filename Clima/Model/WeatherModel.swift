
import Foundation

struct WeatherModel {
    
    //Storage properties
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    //Computed property
    var tempratureString: String {
        return String(format: "%.1f", temperature)
    }
    
    //Computed property
    var conditionName: String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud.fill"
        }
    }
    
}


