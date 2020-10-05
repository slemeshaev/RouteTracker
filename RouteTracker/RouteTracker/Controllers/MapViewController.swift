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
    
    var locationManger: CLLocationManager?
    
    var usselesExampleVariable = ""
    
    // свойство хранения маркера
    var manualMarker: GMSMarker?
    
    // рисуем маршрут
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    // MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureMap()
        configureLocationManager()
    }
    
    
    // конфигурация карты
    private func configureMap() {
        // Центр Москвы
        let coordinate = CLLocationCoordinate2D(latitude: 37.33519572, longitude: -122.03254980)
        // Создаём камеру с использованием координат и уровнем увеличения
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        //Устанавливаем камеру для карты
        mapView.camera = camera
        addMarker(coordinate: coordinate)
    }
    
    // конфигурация менедежера локаций
    private func configureLocationManager() {
        locationManger = CLLocationManager()
        locationManger?.requestAlwaysAuthorization()
        locationManger?.requestWhenInUseAuthorization()
        locationManger?.delegate = self
        locationManger?.requestLocation() // запрос текущей геопозиции
        locationManger?.allowsBackgroundLocationUpdates = true
        locationManger?.requestAlwaysAuthorization()
    }
    
    // метод добавления маркера на карту
    private func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
    
    // метод обновления локации
    private func updateLocation() {
        // Отвязываем от карты старую линию
        route?.map = nil
        // Заменяем старую линию новой
        route = GMSPolyline()
        // Заменяем старый путь новым, пока пустым (без точек)
        routePath = GMSMutablePath() // Добавляем новую линию на карту
        route?.map = mapView
        // Запускаем отслеживание или продолжаем, если оно уже запущено
        locationManger?.startUpdatingLocation()
    }
    
    // показать alert controller
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // начать новый трек
    @IBAction func startTrackTapped(_ sender: UIButton) {
        updateLocation()
        // отслеживание изменение местоположения
        //locationManger?.startUpdatingLocation()
    }
    
    // закончить трек
    @IBAction func endTrackTapped(_ sender: UIButton) {
        //Завершается слежение.
        locationManger?.stopUpdatingLocation()
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

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    private func mapView(_ mapView: GMSMapView, didTap coordinate: CLLocationCoordinate2D) {
        if let manualMarker = manualMarker {
            manualMarker.position = coordinate
        } else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            self.manualMarker = marker
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    // метод обновления локации
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // получения адреса по координатам
        guard let location = locations.last else { return }
        // добавляем ее в путь маршрута
        routePath?.add(location.coordinate)
        // обновляем путь у линии
        route?.path = routePath
        // чтобы наблюдать за движением установим камеру
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        mapView.animate(to: position)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { places, error in
            print(places?.first)
        }
    }
    // метод обработки ошибок при получении локации
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
