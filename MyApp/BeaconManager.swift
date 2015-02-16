//
//  BeaconManager.swift
//  MyApp
//
//  Created by Luppy on 15/2/15.
//  Copyright (c) 2015 Lee Lup Yuen. All rights reserved.
//

//  Remember to set MyApp project properties:
//  General -> Linked Frameworks
//    CoreBluetooth.Framework
//    CoreLocation.Framework
//  Capabilties -> Background Mode
//    Location updates
//    Uses Bluetooth LE Accessories
//  Info -> Custom iOS Target Properties
//    NSLocationAlwaysUsageDescription = For finding beacons nearby
//    Required background modes
//      Item 0 = App communicates using CoreBluetooth
//      Item 1 = App registers for location updates

import UIKit
import CoreLocation
import CoreBluetooth

class BeaconManager: NSObject, CLLocationManagerDelegate, CBPeripheralManagerDelegate {
    var locationManager: CLLocationManager?
    var peripheralManager : CBPeripheralManager?
    var lastProximity: CLProximity?
    
    //  A newly-generated UUID for our beacon
    let beaconUUID = "b9407f30-f5f8-466e-aff9-25556b57fe6d"
    //  The identifier of our beacon is the identifier of our bundle here
    let beaconIdentifier = "iBeaconModules.us"
    //  Made up major and minor versions of our beacon region
    let beaconMajor: CLBeaconMajorValue = 22
    let beaconMinor: CLBeaconMinorValue = 5
    
    func createBeacon()
    {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        peripheralManager = CBPeripheralManager(delegate: self, queue: queue)
        if let manager = peripheralManager
        {
            manager.delegate = self
        }
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!)
    {
        peripheral.stopAdvertising()
        print("The peripheral state is ")
        switch peripheral.state
        {
            case .PoweredOff: println("Powered off")
            case .PoweredOn: println("Powered on")
            case .Resetting: println("Resetting")
            case .Unauthorized: println("Unauthorized")
            case .Unknown: println("Unknown")
            case .Unsupported: println("Unsupported")
        }
        /* Make sure Bluetooth is powered on */
        if peripheral.state != .PoweredOn
        {
            let controller = UIAlertController(title: "Bluetooth", message: "Please turn Bluetooth on", preferredStyle: .Alert)
            controller.addAction(UIAlertAction(title: "OK",
                style: .Default, handler: nil))
            //presentViewController(controller, animated: true, completion: nil)
            NSLog("Please turn Bluetooth on")
        }
        else
        {
            let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: beaconUUID),
                major: beaconMajor,
                minor: beaconMinor,
                identifier: beaconIdentifier)
            let manufacturerData = beaconIdentifier.dataUsingEncoding( NSUTF8StringEncoding,
                allowLossyConversion: false)
            let theUUid = CBUUID(string: beaconUUID)
            let dataToBeAdvertised:[String: AnyObject!] = [
                CBAdvertisementDataLocalNameKey : "Sample peripheral",
                CBAdvertisementDataManufacturerDataKey : manufacturerData,
                CBAdvertisementDataServiceUUIDsKey : [theUUid],
            ]
            peripheral.startAdvertising(dataToBeAdvertised)
            NSLog("created beacon")
        }
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!)
    {
        if error == nil
        {
            println("Successfully started advertising our beacon data")
            let message = "Successfully set up your beacon. " +
                "The unique identifier of our service is: \(beaconUUID)"
            /*
            let controller = UIAlertController(title: "iBeacon", message: message,
                preferredStyle: .Alert)
            controller.addAction(UIAlertAction(title: "OK",
                style: .Default,
                handler: nil))
                presentViewController(controller, animated: true, completion: nil)
            */
            NSLog(message)
        }
        else
        {
            println("Failed to advertise our beacon. Error = \(error)")
        }
    }

    func registerBeacons()
    {
        //  Register beacons.
        let beaconUUID2 = NSUUID(UUIDString: beaconUUID)
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID2,
            identifier: beaconIdentifier)
        beaconRegion.notifyEntryStateOnDisplay = true
        
        locationManager = CLLocationManager()
                    
        //  Prompt for permission to monitor beacons.
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        NSLog("beacons registered")
    }

    func sendLocalNotificationWithMessage(message: String!, playSound: Bool) {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        
        if(playSound) {
            // classic star trek communicator beep
            //	http://www.trekcore.com/audio/
            //
            // note: convert mp3 and wav formats into caf using:
            //	"afconvert -f caff -d LEI16@44100 -c 1 in.wav out.caf"
            // http://stackoverflow.com/a/10388263
            
            ////notification.soundName = "tos_beep.caf";
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!,
        didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            ////  TODO
            ////let viewController:ViewController = window!.rootViewController as ViewController
            ////viewController.beacons = beacons as [CLBeacon]?
            ////viewController.tableView!.reloadData()
            
            /*
            var currentViewController: UIViewController = window!.rootViewController! as UIViewController
            while (currentViewController.presentedViewController != nil)
            {
                currentViewController = currentViewController.presentedViewController!
            }
            */
            
            NSLog("didRangeBeacons");
            var message:String = ""
            var stickerNumber = ""
            
            var playSound = false
            
            if(beacons.count > 0) {
                let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
                stickerNumber = "\(nearestBeacon.major).\(nearestBeacon.minor)"
                
                if(nearestBeacon.proximity == lastProximity ||
                    nearestBeacon.proximity == CLProximity.Unknown) {
                        return;
                }
                lastProximity = nearestBeacon.proximity;
                
                switch nearestBeacon.proximity {
                case CLProximity.Far:
                    //message = "You are far away from the beacon"
                    playSound = true
                case CLProximity.Near:
                    message = "You are near \(nearestBeacon.major),\(nearestBeacon.minor)"
                case CLProximity.Immediate:
                    message = "You are very near \(nearestBeacon.major),\(nearestBeacon.minor)"
                case CLProximity.Unknown:
                    return
                }
            } else {
                
                if(lastProximity == CLProximity.Unknown) {
                    return;
                }
                
                message = "No beacons are nearby"
                playSound = true
                lastProximity = CLProximity.Unknown
            }
            if (message != "")
            {
                NSLog("%@", message)
                sendLocalNotificationWithMessage(message, playSound: playSound)
                /*
                myCodeObject.magicStickerIsNear(mainViewController!,
                    stickerNumber: stickerNumber)
                */
            }
    }
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.startUpdatingLocation()
            
            NSLog("You entered the region")
            sendLocalNotificationWithMessage("You entered the region", playSound: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
            manager.stopUpdatingLocation()
            
            NSLog("You exited the region")
            sendLocalNotificationWithMessage("You exited the region", playSound: true)
    }
}