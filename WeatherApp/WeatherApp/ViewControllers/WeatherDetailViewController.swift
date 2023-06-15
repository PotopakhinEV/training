//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 15.06.2023.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
    private var currentView: WeatherDetailView!
    var weather: [Conditions] = []

    override func loadView() {
        self.currentView = WeatherDetailView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view = currentView
        self.configure()
    }

    override func viewDidLoad() {
        self.title = "Погода на день"
    }
    
    func configure(){
        currentView.tableView.delegate = self
        currentView.tableView.dataSource = self
        currentView.tableView.rowHeight = 80
        self.registerTableViewCells()
    }
}

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.weather.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell") as! WeatherCellTableViewCell
        cell.configure(weather: self.weather[indexPath.row])
        return cell
    }

    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "WeatherCellTableViewCell",
                                  bundle: nil)
        self.currentView.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "DailyWeatherCell")
    }
}

