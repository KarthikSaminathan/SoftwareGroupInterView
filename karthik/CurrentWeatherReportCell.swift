//
//  CurrentWeatherReportCell.swift
//  karthik
//
//  Created by Florakarthik on 19/03/22.
//

import UIKit

class CurrentWeatherReportCell: UICollectionViewCell {
    var currentDayWeatherStackView: UIStackView!
    var dayLabel: UILabel!
    var weatherIcon: UIImageView!
    
    var widthOfIcon: NSLayoutConstraint!
    var heightOfIcon: NSLayoutConstraint!
    var widthOfStackView: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: .zero)
        currentDayWeatherStackView = UIStackView()
        currentDayWeatherStackView.baseSetup(axis: .vertical, spacing: 5, alignment: .center, distribution: .fill, needShadow: true)
        currentDayWeatherStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(currentDayWeatherStackView)
        currentDayWeatherStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        widthOfStackView = currentDayWeatherStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        widthOfStackView.isActive = true
//        currentDayWeatherStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        currentDayWeatherStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        currentDayWeatherStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        dayLabel = UILabel()
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.baseSetup(text: "test", fontSize: 13, color: .white, alignment: .center, needShadow: true)
        currentDayWeatherStackView.addArrangedSubview(dayLabel)


        weatherIcon = UIImageView()
        weatherIcon.image = UIImage.init(named: "sun_cloud_rain")
        currentDayWeatherStackView.addArrangedSubview(weatherIcon)
        widthOfIcon = weatherIcon.widthAnchor.constraint(equalToConstant: 25)
        widthOfIcon.isActive = true
        heightOfIcon = weatherIcon.heightAnchor.constraint(equalToConstant: 25)
        heightOfIcon.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //widthOfContent.constant = 0
        
    }
    
    func setup(hourInfo: Hour, isPortrait: Bool, width: CGFloat) {
        widthOfStackView.constant = width
        if let info = hourInfo.time?.currentWeatherTitle() {
            dayLabel.text = info
        }
        weatherIcon.image = UIImage.init(named: currentWeatherIcon(hourInfo: hourInfo))
        if isPortrait {
            currentDayWeatherStackView.axis = .vertical
            currentDayWeatherStackView.distribution = .fill
            dayLabel.textAlignment = .center
            widthOfIcon.constant = 25
            heightOfIcon.constant = 25
        } else {
            currentDayWeatherStackView.axis = .horizontal
            currentDayWeatherStackView.distribution = .equalSpacing
            dayLabel.textAlignment = .left
            widthOfIcon.constant = 35
            heightOfIcon.constant = 35
            
        }
    }
    func currentWeatherIcon(hourInfo: Hour) -> String {
        let isDay = hourInfo.is_day == 1
        guard let condition = hourInfo.condition, let currentWeatherCondition = condition.text?.lowercased(), !currentWeatherCondition.isEmpty else {
            return "sun"
        }
        if currentWeatherCondition == "clear" {
            return isDay ? "sun" : "moon"
        }
        if currentWeatherCondition == "sunny" {
            return "sun"
        }
        if currentWeatherCondition == "patchy rain possible" {
            return "sun_cloud_rain"
        }
        if currentWeatherCondition == "partly cloudy" {
            return "cloud"
        }
        return "cloud"
    }
}
