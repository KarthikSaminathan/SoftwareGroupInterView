//
//  UpcomingCollectionViewCell.swift
//  karthik
//
//  Created by Florakarthik on 20/03/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    var upcomingWeatherStackView: UIStackView!
    var dayLabel: UILabel!
    var weatherIcon: UIImageView!
    var celView: UIView!
    var minCelLable: UILabel!
    var lineIcon: UIImageView!
    var maxCelLable: UILabel!

    var widthOfIcon: NSLayoutConstraint!
    var heightOfIcon: NSLayoutConstraint!
    var widthOfStackView: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: .zero)
        dayLabel = UILabel()
        dayLabel.baseSetup(text: "test", fontSize: 13, color: .white, alignment: .center, needShadow: true)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dayLabel, anchors: [.leading(10), .centerY(0), .width(70), .height(70)])

        weatherIcon = UIImageView()
        weatherIcon.image = UIImage.init(named: "sun_cloud_rain")
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(weatherIcon, anchors: [.centerX(0), .centerY(0), .width(25), .height(25)])

        celView = UIView()
        self.contentView.addSubview(celView, anchors: [.trailing(0), .top(0), .bottom(0), .width(200), .height(70)])

        minCelLable = UILabel()
        minCelLable.baseSetup(text: "20", fontSize: 13, color: .white, alignment: .left, needShadow: true)
        celView.addSubview(minCelLable, anchors: [.leading(0), .top(0), .bottom(0), .width(30)])

        lineIcon = UIImageView()
        lineIcon.image = UIImage.init(named: "Line")
        celView.addSubview(lineIcon, anchors: [.centerY(0)])
        lineIcon.leadingAnchor.constraint(equalTo: minCelLable.trailingAnchor, constant: 10).isActive = true
        lineIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineIcon.heightAnchor.constraint(equalToConstant: 5).isActive = true

        maxCelLable = UILabel()
        maxCelLable.baseSetup(text: "25", fontSize: 13, color: .white, alignment: .left, needShadow: true)
        celView.addSubview(maxCelLable, anchors: [.top(0), .bottom(0), .trailing(0), .width(30)])
        maxCelLable.leadingAnchor.constraint(equalTo: lineIcon.trailingAnchor, constant: 10).isActive = true
        celView.widthAnchor.constraint(equalToConstant: 150).isActive = true

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //widthOfContent.constant = 0
        //widthOfStackView.constant = self.frame.size.width
    }
    
    func setup(day: Forecastday, isPortrait: Bool, width: CGFloat) {
        if let info = day.date?.givenDate() {
            dayLabel.text = info
        }
        if let dayinfo = day.day {
            weatherIcon.image = UIImage.init(named: currentWeatherIcon(dayInfo: dayinfo))
        }
        if let day = day.day, let minCel = day.mintemp_c, let maxCel = day.maxtemp_c {
            minCelLable.text = "\(minCel)"
            maxCelLable.text = "\(maxCel)"
        }
    }
    func currentWeatherIcon(dayInfo: Day) -> String {
        guard let condition = dayInfo.condition, let currentWeatherCondition = condition.text?.lowercased(), !currentWeatherCondition.isEmpty else {
            return "sun"
        }
        if currentWeatherCondition == "clear" {
            return "sun"
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
