//
//  MapViewController.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 23.09.2020.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManger = CLLocationManager()
    
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        centerViewInUserLocation()
    }
    
    // проверка сервисов геолокаций
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Сервисы локации отключены",
                               message: "Для того чтобы их включить, перейдите в настройки сервисы локации")
            }
        }
    }
    
    // менеджер установки локации
    private func setupLocationManager() {
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // проверка авторизации локации
    private func checkLocationAuthorization() {
        switch locationManger.authorizationStatus {
        case .authorizedWhenInUse:
            mapView.isMyLocationEnabled = true
            break
        case .denied:
            // show alert controller
            print("kuku")
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alert controller
            print("kuku")
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("Доступен новый кейс")
        }
    }
    
    // фокусировка на пользователе
    private func centerViewInUserLocation() {
        if let location = mapView.myLocation {
            print("Локация пользователя: \(location)")
        } else {
            print("Локация не определена!")
        }
//        if let location = locationManger.location?.coordinate {
//            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//            // Создаём камеру с использованием координат и уровнем увеличения
//            let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
//            // Устанавливаем камеру для карты
//            mapView.camera = camera
//            print("Координаты: \(location.latitude) и \(location.longitude)")
//        } else {
//            print("Что-то не так!")
//        }
    }
    
    // начать новый трек
    @IBAction func startTrackTapped(_ sender: UIButton) {
        //Запускается слежение.
        //locationManager?.startUpdatingLocation()
        //Создаётся новая линия на карте или заменяется предыдущая.
        // Отвязываем от карты старую линию
//        route?.map = nil
//        // Заменяем старую линию новой
//        route = GMSPolyline()
//        // Заменяем старый путь новым, пока пустым (без точек)
//        routePath = GMSMutablePath()
//        // Добавляем новую линию на карту
//        route?.map = mapView
        // Запускаем отслеживание или продолжаем, если оно уже запущено
        //locationManager?.startUpdatingLocation()
    }
    
    // показать alert controller
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    // закончить трек
    @IBAction func endTrackTapped(_ sender: UIButton) {
        //Завершается слежение.
        //locationManager?.stopUpdatingLocation()
        //Все точки маршрута сохраняются в базу данных.
        //Прежде чем сохранить точки из базы, необходимо удалить предыдущие точки.
    }
    
    // отобразить предыдущий маршрут
    @IBAction func showPreviousRoute(_ sender: UIButton) {
        //Если в данный момент происходит слежение, то появляется уведомление о том, что сначала необходимо остановить слежение. С кнопкой «ОК», при нажатии на которую останавливается слежение, как если бы пользователь нажал на «Закончить трек».
        //Загружаются точки из базы.
        //На основе загруженных точек строится маршрут.
        //Фокус на карте устанавливается таким образом, чтобы был виден весь маршрут.

    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    // получение координат текущего местоположения
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        // Берём последнюю точку из полученного набора
        guard let location = locations.last else { return }
        // Добавляем её в путь маршрута
        routePath?.add(location.coordinate)
        // Обновляем путь у линии маршрута путём повторного присвоения
        route?.path = routePath
        // Чтобы наблюдать за движением, установим камеру на только что добавленную точку
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        mapView.animate(to: position)
    }
    
    // метод для обработки ошибки получения локации
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
