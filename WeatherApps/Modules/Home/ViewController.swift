//
//  ViewController.swift
//  WeatherApps
//
//  Created by Ahmad Maulana on 15/06/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -Outlet
    @IBOutlet weak var tableView: UITableView!

    var dataCity: [ListCity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
        configureTableView()
        dataCity = ([
            ListCity(idCity: 1642911, cityName: "Jakarta"),
            ListCity(idCity: 1650357, cityName: "Bandung"),
            ListCity(idCity: 1627549, cityName: "Serang"),
            ListCity(idCity: 1627896, cityName: "Semarang"),
            ListCity(idCity: 1625084, cityName: "Tangerang"),
            ListCity(idCity: 1649378, cityName: "Bekasi"),
            ListCity(idCity: 1621177, cityName: "Jogjakarta"),
            ListCity(idCity: 1625822, cityName: "Surabaya"),
            ListCity(idCity: 1648473, cityName: "Bogor"),
            ListCity(idCity: 8144495, cityName: "Depok")
        ])
        tableView.reloadData()
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    func customizeNavigationBar() {
        title = "List City"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCity.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataCity[indexPath.row].cityName
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailCityViewController") as! DetailCityViewController
        detailVC.cityId = dataCity[indexPath.row].idCity ?? 0
        detailVC.cityName = dataCity[indexPath.row].cityName ?? ""
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

