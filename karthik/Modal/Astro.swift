
import Foundation
public class Astro {
	public var sunrise : String?
	public var sunset : String?
	public var moonrise : String?
	public var moonset : String?
	public var moon_phase : String?
	public var moon_illumination : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Astro] {
        var models:[Astro] = []
        for item in array {
            models.append(Astro(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		sunrise = dictionary["sunrise"] as? String
		sunset = dictionary["sunset"] as? String
		moonrise = dictionary["moonrise"] as? String
		moonset = dictionary["moonset"] as? String
		moon_phase = dictionary["moon_phase"] as? String
		moon_illumination = dictionary["moon_illumination"] as? String
	}

	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.sunrise, forKey: "sunrise")
		dictionary.setValue(self.sunset, forKey: "sunset")
		dictionary.setValue(self.moonrise, forKey: "moonrise")
		dictionary.setValue(self.moonset, forKey: "moonset")
		dictionary.setValue(self.moon_phase, forKey: "moon_phase")
		dictionary.setValue(self.moon_illumination, forKey: "moon_illumination")
		return dictionary
	}
}
