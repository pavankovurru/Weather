
import Foundation
import CoreLocation

protocol WeatherBrainDelegate {
    func didUpdateWeather(weatherBrain: WeatherBrain, weather: WeatherModel)
    func didFailWithError(error: Error)
}



struct WeatherBrain {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?appid=906a77a664a9213cc1bc9a612d036b4d"
    
    var delegate: WeatherBrainDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)&units=imperial"
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&units=imperial&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let errorUnWrapped = error {
                    print(errorUnWrapped)
                    self.delegate?.didFailWithError(error: errorUnWrapped)
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(weatherBrain: self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.list[0].weather[0].id
            let temp = decodedData.list[0].main.temp
            let name = decodedData.list[0].name
            
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.tempratureString)
            
            return weather
        
            
            
        } catch{
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    

    
}

