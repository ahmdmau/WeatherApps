//
//  DetailCityViewController.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import UIKit
import JGProgressHUD

class DetailCityViewController: UIViewController {

    var weatherNetwork = WeatherNetwork()
    var datas: CurrentWeather? {
        didSet {
            updateUI()
        }
    }
    var dataForecast: ForecastData? {
        didSet {
            tableView.reloadData()
        }
    }
    let hud = JGProgressHUD(style: .dark)
    var cityId: Int = 0
    var cityName: String = ""

    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var currentWindLbl: UILabel!
    @IBOutlet weak var currentRainLbl: UILabel!
    @IBOutlet weak var currentHumidityLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDatas(cityId)
        fetchForecastData(cityId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavbar()
    }

    func fetchDatas(_ cityId: Int) {
        hud.show(in: view)
        weatherNetwork.fetchCurrentWeather(city: cityId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.datas = data
                self?.hud.dismiss()
            case .failure(let error):
                Helper().showAlertWithTitle(msg: error.localizedDescription, controller: self!)
            }
        }
    }

    func fetchForecastData(_ cityId: Int) {
        weatherNetwork.fetchForecast(city: cityId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataForecast = data
            case .failure(let error):
                Helper().showAlertWithTitle(msg: error.localizedDescription, controller: self!)
            }
        }
    }

    func updateUI() {

        let temperature = self.datas?.main?.temp ?? 0.0
        let tempMax = self.datas?.main?.tempMax ?? 0.0
        let currentTemp = String(format: "%.0f", temperature - 273.15)
        let currentTempMax = String(format: "%.0f", tempMax - 273.15)

        currentWeatherImg.image = UIImage(named: self.datas?.weather?[0].main ?? "")
        currentTemperature.text = "\(currentTemp)°"
        currentDate.text = convertDateToString(Date())
        currentWeatherLbl.text = self.datas?.weather?[0].weatherDescription ?? ""
        currentWindLbl.text = "\(self.datas?.wind?.speed ?? 0.0) mph"
        currentRainLbl.text = "\(currentTempMax)°"
        currentHumidityLbl.text = "\(self.datas?.main?.humidity ?? 0)%"
    }

    func configureNavbar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()

        navBarAppearance.titleTextAttributes = [
            .foregroundColor : UIColor.white
        ]

        navBarAppearance.backgroundColor = UIColor.init(hex: "1AC6FF", alpha: 1)

        let transNavBarAppearance = navBarAppearance.copy()
        transNavBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = transNavBarAppearance
        navigationController?.navigationBar.tintColor = UIColor.white

        title = cityName
        navigationItem.largeTitleDisplayMode = .never
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: "ForecastCell")
    }

}

extension DetailCityViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForecast?.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        cell.dataList = self.dataForecast?.list?[indexPath.row]
        return cell
    }


}
