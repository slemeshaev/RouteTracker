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
    
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    // координаты ВДНХ
    let coordinate = CLLocationCoordinate2D(latitude: 55.8257065, longitude: 37.6384964)
    // свойство locationManager
    var locationManager: CLLocationManager?
    // свойство маркер
    var marker: GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
    
    // конфигурация карты
    func configureMap() {
        // Создаём камеру с использованием координат и уровнем увеличения
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        // Устанавливаем камеру для карты
        mapView.camera = camera
    }
    
    // конфигурация LocationManager
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.requestAlwaysAuthorization()
    }
    
    // начать новый трек
    @IBAction func startTrackTapped(_ sender: UIButton) {
        //Запускается слежение.
        locationManager?.startUpdatingLocation()
        //Создаётся новая линия на карте или заменяется предыдущая.
        // Отвязываем от карты старую линию
        route?.map = nil
        // Заменяем старую линию новой
        route = GMSPolyline()
        // Заменяем старый путь новым, пока пустым (без точек)
        routePath = GMSMutablePath()
        // Добавляем новую линию на карту
        route?.map = mapView
        // Запускаем отслеживание или продолжаем, если оно уже запущено
        locationManager?.startUpdatingLocation()
    }
    
    
    // закончить трек
    @IBAction func endTrackTapped(_ sender: UIButton) {
        //Завершается слежение.
        locationManager?.stopUpdatingLocation()
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
