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
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    // получение координат текущего местоположения
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.first {
            let marker = GMSMarker(position: location.coordinate)
            marker.map = mapView
            self.marker = marker
            mapView.animate(toLocation: location.coordinate)
        }
    }
    
    // метод для обработки ошибки получения локации
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
