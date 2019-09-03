//
//  MapViewController.swift
//  Nearme
//
//  Created by Alumnos on 5/20/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func localiza() {
        initlocation()
    }
    
    
    func initlocation(){
        let permiso = CLLocationManager.authorizationStatus()
        if permiso == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }else if permiso == .denied {
            alertlocation(tit: "Error de localizacion", men: "Actualmente tiene denegada la localizacion del dispositivo")
        }else if permiso == .restricted {
            alertlocation(tit: "Error de localizacion", men: "Actualmente tiene restringida la localizacion del dispositivo")
        }else {
            guard let currentCoordinate = locationManager.location?.coordinate else { return }
            let region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    func alertlocation(tit: String, men: String){
        let alerta = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta,animated: true,completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController: MKMapViewDelegate {
    
  
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
    }
}
