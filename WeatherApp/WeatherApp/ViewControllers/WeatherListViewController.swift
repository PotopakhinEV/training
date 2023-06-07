//
//  ViewController.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 23.04.2023.
//

import UIKit

class WeatherListViewController: UIViewController {
    var weather: VisualCorssingWeather? = nil

    private var currentView: WeatherListView!

    override func loadView() {
        self.currentView = WeatherListView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view = currentView
        self.currentView.viewDelegate = self
        self.configure()
    }

    override func viewDidLoad() {
      super.viewDidLoad()
    }

    func showErrorAlert(error: RequestWeatherError) {
        let alertController = UIAlertController(title: "Произошла ошибка", message: error.getTextError(), preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Понятно", style: .cancel, handler: nil)
        self.currentView.headerLabel.text = "Для запроса погоды укажите город"
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }

    func loader(active: Bool) {
        if active {
            self.currentView.loaderIndicator.startAnimating()
            self.currentView.loaderIndicator.isHidden = false
        } else {
            self.currentView.loaderIndicator.stopAnimating()
            self.currentView.loaderIndicator.isHidden = true
        }
    }
    
    func configure(){
        currentView.tableView.delegate = self
        currentView.tableView.dataSource = self
    }
}

extension WeatherListViewController: WeatherListViewDelegate {
    func showAlertVC() {
        let alertController = UIAlertController(title: "Введите название города", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Название"
        }

        let createButton = UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            guard let self = self else { return  }

            guard let cityName = alertController.textFields?[0].text else {
                self.showErrorAlert(error: RequestWeatherError.badCity)
                return
            }
            self.getWeather(cityName)
        }

        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alertController.addAction(cancelButton)
        alertController.addAction(createButton)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.weather?.days.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "DailyWeatherCell")
        }
        configure(cell: &cell, for: indexPath)

        return cell
    }

    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = self.weather?.days[indexPath.row].datetime
        configuration.secondaryText = String(format: "%.1f", self.weather?.days[indexPath.row].FtoCConvert() ?? 0)
        cell.contentConfiguration = configuration
    }
}

extension WeatherListViewController {
    private func getWeather(_ city: String) {
        self.loader(active: true)

        VisualCorssingWeather.requestWeather(city) {[weak self] weather, error  in
            guard let self = self else { return }
            self.loader(active: false)

            if weather != nil {
                self.weather = weather

                DispatchQueue.main.async {
                    self.currentView.tableView.reloadData()
                }

                self.currentView.headerLabel.text = "Для повторного запроса измените город"
            }
            
            if error != nil {
                self.showErrorAlert(error: error ?? RequestWeatherError.unknow)
            }
        }
    }
}
