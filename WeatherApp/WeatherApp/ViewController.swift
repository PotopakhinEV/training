//
//  ViewController.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 23.04.2023.
//

import UIKit

class ViewController: UIViewController {
    var weather: VisualCorssingWeather? = nil
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showNewGetCityAlert() {
        let alertController = UIAlertController(title: "Введите название города", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Название"
        }
        let createButton = UIAlertAction(title: "Готово", style: .default) {
            _ in
            self.headerLabel.text = "Загрузка..."
            guard let cityName = alertController.textFields?[0].text else {
                self.showErrorAlert(error: RequestWeatherError.badCity)
                return
            }

            VisualCorssingWeather.requestWeather(cityName) {[weak self] weather, error  in
                guard error == nil && weather != nil else {
                    self?.showErrorAlert(error: error!)
                    return
                }
                self?.weather = weather
                self?.tableView.reloadData()
                self?.headerLabel.text = "Для повторного запроса измените город"
            }
        }

        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alertController.addAction(cancelButton)
        alertController.addAction(createButton)

        self.present(alertController, animated: true, completion: nil)
    }

    func showErrorAlert(error: RequestWeatherError) {
        let alertController = UIAlertController(title: "Произошла ошибка", message: error.getTextError(), preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Понятно", style: .cancel, handler: nil)
        self.headerLabel.text = "Для запроса погоды укажите город"
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
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
