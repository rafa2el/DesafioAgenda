//
//  MapViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 26/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreLocation //determina a localizacao do usuario
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate{
 
    @IBOutlet weak var mapView: MKMapView!
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    var editContato: Contato!

//    let localInicial = CLLocation(latitude: -29.3666, longitude: -52.2612)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        
        mapView.mapType = .standard
        
       let endereco = String("\(editContato.endereco!),\(editContato.numero),\(editContato.cep!)")
       
       MapViewController.geocoder.geocodeAddressString(endereco) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("Erro location!!")
                    return
            }

            let span = MKCoordinateSpan(latitudeDelta: 0.0175, longitudeDelta: 0.0175)
            let regiao = MKCoordinateRegion(center: location.coordinate, span: span)
            self.mapView.setRegion(regiao, animated: true)
        
            let anotacao = MKPointAnnotation()
            anotacao.coordinate = location.coordinate
            anotacao.title = "Aqui!"
        
            self.mapView.addAnnotation(anotacao)
        }
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let local = locations[locations.count-1]
        
        if local.horizontalAccuracy > 0.0 {
            lm.stopUpdatingLocation()
            print("\(local.coordinate.latitude), \(local.coordinate.longitude)")
            MapViewController.geocoder.reverseGeocodeLocation(local) { (placemarks, _) in
                if let marca = placemarks?.first {
                    print(marca)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
}
