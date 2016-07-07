//
//  ViewController.swift
//  appBeaconDistance
//
//  Created by AGTechnologies Produtos Eletronicos Ltda. on 04/07/16.
//  Copyright © 2016 AGTechnologies Produtos Eletronicos Ltda. All rights reserved.
//

import CoreLocation
import UIKit


class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBOutlet weak var statusBeacon: UIImageView!
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.blackColor()
    }
    
    func startScanning()
    {
        let uuid = NSUUID(UUIDString: "669A0C20-0008-969E-E211-9EB1E2F273D9")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 00, minor: 00, identifier: "Beacon ST")
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
    }
    
    func updateDistance (distance:CLProximity)
    {
        UIView.animateWithDuration(1)
        { [unowned self] in
            switch distance
            {
            case .Unknown:
                self.view.backgroundColor = UIColor.blackColor()
                self.statusBeacon.image = UIImage(named: "Nenhum")
                
            case .Far:
                self.view.backgroundColor = UIColor.cyanColor()
                self.statusBeacon.image = UIImage(named: "Longe")
                
            case .Near:
                self.view.backgroundColor = UIColor.yellowColor()
                self.statusBeacon.image = UIImage(named: "Perto")
                
            case .Immediate:
                self.view.backgroundColor = UIColor.orangeColor()
                self.statusBeacon.image = UIImage(named: "Aqui")
            }
        }
    }
    
   
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == CLAuthorizationStatus.AuthorizedAlways
        {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self)
            {
                if CLLocationManager.isRangingAvailable()
                {
                   startScanning()
                }
            }
        
        }
    }
        
        func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
        {
            if beacons.count > 0
            {
                let beacon = beacons.first! as CLBeacon
                updateDistance(beacon.proximity)
            }
            else
            {
                updateDistance(.Unknown)
            }

        }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

