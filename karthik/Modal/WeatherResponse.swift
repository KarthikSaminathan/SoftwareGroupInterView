
import Foundation
public class WeatherResponse {
	public var location : Location?
	public var current : Current?
	public var forecast : Forecast?

    init() {
        
    }
    public class func modelsFromDictionaryArray(array:NSArray) -> [WeatherResponse] {
        var models:[WeatherResponse] = []
        for item in array {
            models.append(WeatherResponse(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		if (dictionary["location"] != nil) { location = Location(dictionary: dictionary["location"] as! NSDictionary) }
		if (dictionary["current"] != nil) { current = Current(dictionary: dictionary["current"] as! NSDictionary) }
		if (dictionary["forecast"] != nil) { forecast = Forecast(dictionary: dictionary["forecast"] as! NSDictionary) }
	}

	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.location?.dictionaryRepresentation(), forKey: "location")
		dictionary.setValue(self.current?.dictionaryRepresentation(), forKey: "current")
		dictionary.setValue(self.forecast?.dictionaryRepresentation(), forKey: "forecast")
		return dictionary
	}
}
