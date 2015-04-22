//
//  FirstViewController.swift
//  Parkbook
//
//  Created by Kristofor Carle on 4/12/15.
//  Copyright (c) 2015 Kristofor Carle. All rights reserved.
//


import UIKit


class FirstViewController: UIViewController, BeaconManagerDelegate, UIAlertViewDelegate {

    var mapView: MGLMapView!
    
    var beaconManager: BeaconManager?
    var beaconList = Dictionary<String, Bool>() // major+minor -> yes or no

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeMap()
        
        self.beaconManager = sharedBeaconManager
        self.beaconManager?.delegate = self
        self.beaconManager?.start()
        
           }
    

    func initializeMap() {
        
        //set your MapBox account token - see: https://www.mapbox.com/account/apps/
        let mapBoxAccountToken = "INSERT TOKEN HERE"
        
        //frame for the map view
        let mapFrame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)
        
        //instantiate a MapBoxGL map
        mapView = MGLMapView(frame: mapFrame, accessToken: mapBoxAccountToken)
        mapView.tintColor = UIColor(red: 30, green: 30, blue: 30, alpha: 1)
        
        //set the default style
        mapView.useBundledStyleNamed("outdoors")
        
        //zoom map to area of interest
        let lat = 38.889487
        let lng = -77.0347045
        let centerCoordinate = CLLocationCoordinate2DMake(lat, lng)
        mapView.setCenterCoordinate(centerCoordinate, zoomLevel: 14, animated: true)
        
        //add the map to the parent view
        view.addSubview(mapView)
    }
    
    func insideRegion(regionIdentifier: String) {
        //        println("VC insideRegion \(regionIdentifier)")
        //self.beaconList[regionIdentifier] = true
        //self.setUI()
        sendLocalNotificationWithMessage(regionIdentifier, playSound: false) // Only send notification when we enter
    }
    
    func didEnterRegion(regionIdentifier: String) {
        println("VC didEnterRegion \(regionIdentifier)")
        //self.beaconList[regionIdentifier] = true
        //self.setUI()
        sendLocalNotificationWithMessage(regionIdentifier, playSound: false) // Only send notification when we enter
    }
    
    func didExitRegion(regionIdentifier: String) {
        println("VC didExitRegion \(regionIdentifier)")
        //self.beaconList[regionIdentifier] = nil
        //self.setUI()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sendLocalNotificationWithMessage(message: String!, playSound: Bool) {
        let notification:UILocalNotification = UILocalNotification()
        let alertMessage = "Checked into park: " + message;
        notification.alertBody = alertMessage
        
        if(playSound) {
            // classic star trek communicator beep
            //	http://www.trekcore.com/audio/
            //
            // note: convert mp3 and wav formats into caf using:
            //	"afconvert -f caff -d LEI16@44100 -c 1 in.wav out.caf"
            // http://stackoverflow.com/a/10388263
            
            notification.soundName = "tos_beep.caf";
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        let alertView = UIAlertController(title: "Checked In", message: alertMessage, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
   
        
    }
    
   }


