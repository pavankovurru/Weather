
import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBox: UITextField!
    
    var weatherBrain = WeatherBrain()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()  // one time user location

        searchBox.delegate = self
        weatherBrain.delegate = self
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchBox.endEditing(true) //dismiss keyboard
        print(searchBox.text!)
        
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBox.endEditing(true) //dismiss keyboard
        print(searchBox.text!)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Type SomeThing"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchBox.text {
            weatherBrain.fetchWeather(cityName: city)
        } else {
            
        }
        
        searchBox.text = ""
    }
    
}

extension WeatherViewController: WeatherBrainDelegate{
    
    func didUpdateWeather(weatherBrain: WeatherBrain, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
}


extension WeatherViewController: CLLocationManagerDelegate{

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location data.")
        
        if let location = locations.last{
            //This is required ao that next get location will have fresh data
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            weatherBrain.fetchWeather(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
