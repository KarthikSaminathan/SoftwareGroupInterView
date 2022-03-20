//
//  WeatherPageViewModal.swift
//  karthik
//
//  Created by Florakarthik on 20/03/22.
//

import Foundation


class WeatherPageViewModal {
    var weatherResponse = WeatherResponse()
    func getWeatherReport(withCompletionHandler completionHandler: @escaping (_ status: Bool, _ error: String?) -> Void) {

        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502&q=chennai&days=7&aqi=no&alerts=no")
        url?.asyncDownload(completion: { data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    print(jsonResult)
                    if let results = WeatherResponse(dictionary: jsonResult as NSDictionary) {
                        self.weatherResponse = results
                        completionHandler(true, nil)
                    } else {
                        completionHandler(false, "Something went Wrong")
                    }
                }
            } catch let parseError {
                completionHandler(false, parseError.localizedDescription)
            }
        })
    }
    
    func cityName() -> String {
        guard let name = weatherResponse.location?.name else {
            return ""
        }
        return name
    }
    
    func currentWeatherInformation() -> String {
        guard let currentDay = weatherResponse.forecast?.forecastday?.first?.day, let minCel = currentDay.mintemp_c, let maxCel = currentDay.maxtemp_c  else {
            return "No information available"
        }
        return "Minimum celsius \(minCel) & Maximum celsius \(maxCel)"
    }
    
    func currentDayWeatherArray() -> [Hour] {
        guard let currentDay = weatherResponse.forecast?.forecastday?.first, let hoursArr = currentDay.hour, hoursArr.count > 0 else {
            return []
        }
        return hoursArr
    }
    func currentWeatherArrayCount() -> Int {
        return currentDayWeatherArray().count
    }
    func currentHour(index: Int) -> Hour {
        let hourArr = currentDayWeatherArray()
        guard hourArr.count > index else {
            return Hour()
        }
        return hourArr[index]
    }
    
    func upcomingDaysArr() -> [Forecastday] {
        guard let forcastDays = weatherResponse.forecast?.forecastday, forcastDays.count > 0 else {
            return []
        }
        return forcastDays
    }
    func upcomingDaysArrayCount() -> Int {
        return upcomingDaysArr().count
    }
    func particularDay(index: Int) -> Forecastday {
        let arr = upcomingDaysArr()
        guard arr.count > 0, arr.count > index else {
            return Forecastday()
        }
        return arr[index]
    }
}
