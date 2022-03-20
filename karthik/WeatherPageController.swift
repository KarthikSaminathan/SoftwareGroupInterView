//
//  ViewController.swift
//  karthik
//
//  Created by Florakarthik on 17/03/22.
//

import UIKit

class WeatherPageController: UIViewController {

    var backThemeImageView: UIImageView!
    var scrollView: UIScrollView!
    var topHeaderStackView: UIStackView!
    var countryStackView: UIStackView!
    var countryFlag: UIImageView!
    var countryNameLable: UILabel!
    var cityNameLabel: UILabel!
    var dateTimeLabel: UILabel!

    var weatherStackView: UIStackView!
    var currentDayWeatherView: UIView!
    var currentDayWeatherTitleLable: UILabel!
    var currentDayWeathersCollectionView: UICollectionView!
    let currentWeatherCollectionFlowLayout = UICollectionViewFlowLayout()
    var nextUpcomingWeatherView: UIView!
    var upcomingyWeathersCollectionView: UICollectionView!
    var nextUpcomingWeatherCollectionFlowLayout = UICollectionViewFlowLayout()
    var nextWeatherTitleLable: UILabel!

    var ticketTop : NSLayoutConstraint?
    var heightOfCurrentDayWeatherView: NSLayoutConstraint!
    var heightOfUpcomingWeatherView: NSLayoutConstraint!
    var widthOfCurrentDayWeatherView: NSLayoutConstraint!
    var leadingUpcomingWeatherCollectionView: NSLayoutConstraint!
    var isPortrait = true
    var widthOfCollectionView = 50.0
    var widthOfUpcomingCollectionView = 50.0
    
    var viewmodal = WeatherPageViewModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        widthOfUpcomingCollectionView = self.view.frame.size.width-30
        setupBackThemeImageView()
        setupScrollView()
        setupTopHeaderView()
        setupTopHeaderViewItems()
        setupCurrentWeatherView()
        setupCurrentWeatherViewItems()
        setupUpcomingWeatherViewItems()
        
        viewmodal.getWeatherReport { status, error in
            if status {
                OperationQueue.main.addOperation {
                    self.cityNameLabel.text = self.viewmodal.cityName()
                    self.currentDayWeatherTitleLable.text = self.viewmodal.currentWeatherInformation()
                    self.currentDayWeathersCollectionView.reloadData()
                    self.upcomingyWeathersCollectionView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: error ?? "Something Went Wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UIWindow.isLandscape {
             landscapeUpdate()
            isPortrait = false
        } else {
             portraitUpdate()
            isPortrait = true
        }
    }
    func setupBackThemeImageView() {
        backThemeImageView = UIImageView.init(image: UIImage.init(named: "theme"))
        backThemeImageView.contentMode = .scaleToFill
        view.addSubview(backThemeImageView, anchors: [.leading(0), .trailing(0), .bottom(0), .top(0)])
    }
    func setupScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView, anchors: [.leading(0), .trailing(0), .bottom(0), .top(0)])
    }
    func setupTopHeaderView() {
        topHeaderStackView = UIStackView()
        topHeaderStackView.baseSetup(axis: .vertical, alignment: .center, distribution: .equalSpacing)
        topHeaderStackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(topHeaderStackView, anchors: [.leading(0), .trailing(0)])
        ticketTop = topHeaderStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50)
        ticketTop?.isActive = true
        topHeaderStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    func setupTopHeaderViewItems() {
        countryStackView = UIStackView()
        topHeaderStackView.baseSetup(axis: .horizontal, spacing: 15, alignment: .center, distribution: .fill, needShadow: true)

        topHeaderStackView.addArrangedSubview(countryStackView)
        
        countryFlag = UIImageView()
        countryFlag.contentMode = .scaleAspectFit
        countryFlag.image = UIImage.init(named: "indianFlag")
        countryFlag.widthAnchor.constraint(equalToConstant: 35).isActive = true
        countryStackView.addArrangedSubview(countryFlag)
        
        countryNameLable = UILabel()
        countryNameLable.baseSetup(text: "India", fontSize: 33, color: .white, alignment: .center)
        countryStackView.addArrangedSubview(countryNameLable)

        cityNameLabel = UILabel()
        cityNameLabel.baseSetup(text: "Porur, Chennai", fontSize: 25, color: .white, alignment: .center, needShadow: true)
        topHeaderStackView.addArrangedSubview(cityNameLabel)
        
        dateTimeLabel = UILabel()
        dateTimeLabel.baseSetup(text: Date().inString(), fontSize: 15, color: .white, alignment: .center, needShadow: true)
        topHeaderStackView.addArrangedSubview(dateTimeLabel)
    }
    
    func setupCurrentWeatherView() {
        weatherStackView = UIStackView()
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherStackView.baseSetup(axis: .vertical, spacing: 15, alignment: .fill, distribution: .fill)
        scrollView.addSubview(weatherStackView)
        
        weatherStackView.topAnchor.constraint(equalTo: topHeaderStackView.bottomAnchor, constant: 50).isActive = true
        weatherStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        weatherStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30).isActive = true
        weatherStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        currentDayWeatherView = UIView()
        currentDayWeatherView.backgroundColor = CustomColors.viewColor
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        currentDayWeatherView.applyLightShadow()
        currentDayWeatherView.applyCornerRadius(radius: 15)
        weatherStackView.addArrangedSubview(currentDayWeatherView)
        currentDayWeatherView.translatesAutoresizingMaskIntoConstraints = false
        heightOfCurrentDayWeatherView = currentDayWeatherView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        heightOfCurrentDayWeatherView.isActive = true
        widthOfCurrentDayWeatherView = currentDayWeatherView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 0.25)
        widthOfCurrentDayWeatherView.isActive = false
        
        nextUpcomingWeatherView = UIView()
        nextUpcomingWeatherView.backgroundColor = CustomColors.viewColor
        nextUpcomingWeatherView.applyLightShadow()
        nextUpcomingWeatherView.applyCornerRadius(radius: 15)
        weatherStackView.addArrangedSubview(nextUpcomingWeatherView)
        nextUpcomingWeatherView.translatesAutoresizingMaskIntoConstraints = false
        heightOfUpcomingWeatherView = nextUpcomingWeatherView.heightAnchor.constraint(equalToConstant: 400)
        heightOfUpcomingWeatherView.isActive = true
    }
    
    func setupCurrentWeatherViewItems() {
        currentDayWeatherTitleLable = UILabel()
        currentDayWeatherTitleLable.baseSetup(text: "Parties cloudly conditions expected around 4pm", fontSize: 15, color: .white, alignment: .left, needShadow: true)
        currentDayWeatherView.addSubview(currentDayWeatherTitleLable, anchors: [.top(15), .leading(15), .trailing(15)])


        currentWeatherCollectionFlowLayout.scrollDirection = .horizontal
        currentWeatherCollectionFlowLayout.minimumLineSpacing = 0
        currentWeatherCollectionFlowLayout.minimumInteritemSpacing = 0
        currentWeatherCollectionFlowLayout.estimatedItemSize = .zero
        currentWeatherCollectionFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        
        currentDayWeathersCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: currentWeatherCollectionFlowLayout)
        
        currentDayWeathersCollectionView.backgroundColor = .clear
        currentDayWeathersCollectionView.dataSource = self
        currentDayWeathersCollectionView.delegate = self
        currentDayWeathersCollectionView.register(CurrentWeatherReportCell.self, forCellWithReuseIdentifier: "CurrentWeatherReportCell")
        currentDayWeathersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        currentDayWeatherView.addSubview(currentDayWeathersCollectionView)

        currentDayWeathersCollectionView.topAnchor.constraint(equalTo: currentDayWeatherTitleLable.bottomAnchor, constant: 15).isActive = true
        currentDayWeathersCollectionView.leadingAnchor.constraint(equalTo: currentDayWeatherView.leadingAnchor, constant: 15).isActive = true
        currentDayWeathersCollectionView.trailingAnchor.constraint(equalTo: currentDayWeatherView.trailingAnchor, constant: 15).isActive = true
        currentDayWeathersCollectionView.bottomAnchor.constraint(equalTo: currentDayWeatherView.bottomAnchor, constant: 15).isActive = true
        currentDayWeathersCollectionView.reloadData()
        
    }
    func setupUpcomingWeatherViewItems() {
        nextWeatherTitleLable = UILabel()
        nextWeatherTitleLable.baseSetup(text: "Parties cloudly conditions expected around 4pm", fontSize: 15, color: .white, alignment: .left, needShadow: true)
        nextUpcomingWeatherView.addSubview(nextWeatherTitleLable, anchors: [.top(15), .leading(15), .trailing(15)])


        nextUpcomingWeatherCollectionFlowLayout.scrollDirection = .vertical
        nextUpcomingWeatherCollectionFlowLayout.minimumLineSpacing = 0
        nextUpcomingWeatherCollectionFlowLayout.minimumInteritemSpacing = 0
        nextUpcomingWeatherCollectionFlowLayout.estimatedItemSize = .zero
        nextUpcomingWeatherCollectionFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        upcomingyWeathersCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: nextUpcomingWeatherCollectionFlowLayout)
       
        upcomingyWeathersCollectionView.backgroundColor = .clear
        upcomingyWeathersCollectionView.dataSource = self
        upcomingyWeathersCollectionView.delegate = self
        upcomingyWeathersCollectionView.register(UpcomingCollectionViewCell.self, forCellWithReuseIdentifier: "UpcomingCollectionViewCell")
        upcomingyWeathersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nextUpcomingWeatherView.addSubview(upcomingyWeathersCollectionView)

        upcomingyWeathersCollectionView.topAnchor.constraint(equalTo: nextWeatherTitleLable.bottomAnchor, constant: 15).isActive = true
        leadingUpcomingWeatherCollectionView = upcomingyWeathersCollectionView.leadingAnchor.constraint(lessThanOrEqualTo: nextWeatherTitleLable.leadingAnchor)
        leadingUpcomingWeatherCollectionView.isActive = true
        upcomingyWeathersCollectionView.trailingAnchor.constraint(greaterThanOrEqualTo: nextUpcomingWeatherView.trailingAnchor, constant: 0).isActive = true
        upcomingyWeathersCollectionView.bottomAnchor.constraint(equalTo: nextUpcomingWeatherView.bottomAnchor, constant: 0).isActive = true
        upcomingyWeathersCollectionView.reloadData()
        
        
    }
    
    func portraitUpdate() {
        backThemeImageView.image = UIImage.init(named: "theme")
        topHeaderStackView.axis = .vertical
        topHeaderStackView.alignment = .center
        topHeaderStackView.distribution = .fillProportionally

        ticketTop?.constant = 50
        
        countryStackView.alignment = .center
        countryStackView.spacing = 15
        
        countryNameLable.font = UIFont.systemFont(ofSize: 33)
        countryNameLable.textAlignment = .center
        
        dateTimeLabel.textAlignment = .center
        
        weatherStackView.axis = .vertical
        widthOfCurrentDayWeatherView.isActive = false
        
        currentWeatherCollectionFlowLayout.scrollDirection = .horizontal
        currentDayWeathersCollectionView.setCollectionViewLayout(currentWeatherCollectionFlowLayout, animated: true)
        leadingUpcomingWeatherCollectionView.constant = 0
        var width = 0.0
        if view.frame.size.width > view.frame.size.height {
            width = view.frame.size.height
        } else {
            width = view.frame.size.width
        }
        self.widthOfUpcomingCollectionView = width-60
        self.view.layoutIfNeeded()
        OperationQueue.main.addOperation {
            self.currentDayWeathersCollectionView.reloadData()
            self.upcomingyWeathersCollectionView.reloadData()
        }
    }
    func landscapeUpdate() {
        backThemeImageView.image = UIImage.init(named: "theme_landscape")
        topHeaderStackView.axis = .horizontal
        topHeaderStackView.alignment = .fill
        topHeaderStackView.distribution = .fillEqually
        
        ticketTop?.constant = 20
        
        countryStackView.alignment = .fill
        countryStackView.spacing = 0

        countryNameLable.font = UIFont.systemFont(ofSize: 25)
        countryNameLable.textAlignment = .left
        
        dateTimeLabel.textAlignment = .right
        
        weatherStackView.axis = .horizontal
        widthOfCurrentDayWeatherView.isActive = true
        currentWeatherCollectionFlowLayout.scrollDirection = .vertical
        currentDayWeathersCollectionView.setCollectionViewLayout(currentWeatherCollectionFlowLayout, animated: true)
        leadingUpcomingWeatherCollectionView.constant = -50
        self.widthOfCollectionView = self.view.frame.size.height*0.32
        self.widthOfUpcomingCollectionView = self.nextUpcomingWeatherView.frame.size.width
        self.view.layoutIfNeeded()
        OperationQueue.main.addOperation {
            self.currentDayWeathersCollectionView.reloadData()
            self.upcomingyWeathersCollectionView.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            isPortrait = false
            landscapeUpdate()
        } else {
            isPortrait = true
            widthOfCollectionView = 50
            portraitUpdate()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.currentDayWeathersCollectionView.reloadData()
    }
    
}
extension WeatherPageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == currentDayWeathersCollectionView ? viewmodal.currentWeatherArrayCount() : viewmodal.upcomingDaysArrayCount()
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == currentDayWeathersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentWeatherReportCell", for: indexPath) as! CurrentWeatherReportCell
            cell.setup(hourInfo: viewmodal.currentHour(index: indexPath.row), isPortrait: isPortrait, width: widthOfCollectionView)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as! UpcomingCollectionViewCell
            cell.setup(day: viewmodal.particularDay(index: indexPath.row), isPortrait: true, width: widthOfUpcomingCollectionView-30)
            return cell
        }
    }
}
extension WeatherPageController: UICollectionViewDelegate {
    
}
extension WeatherPageController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard collectionView == currentDayWeathersCollectionView else {
            return CGSize.init(width: widthOfUpcomingCollectionView, height: 70)
        }
        guard !isPortrait else {
            return CGSize.init(width: 80, height: 70)
        }
        return CGSize.init(width: widthOfCollectionView, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
}
    
