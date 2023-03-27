//
//  MapController.swift
//  Bredge
//
//  Created by suryaween on 13/09/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
class MapController: UIViewController, CLLocationManagerDelegate {
    static let nibName = "MapController"
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let m = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView = m

    }
    
    @IBAction func globalButtonClick(_ sender: Any) {
        self.goToPreviousController()
    }
    @IBAction func spinBtnClicked(_ sender: Any) {
        
        self.pushToNextController(controllerName: SpinController.loadController())
        
    }
    @IBAction func eventBtnClicked(_ sender: Any) {
        self.pushToNextController(controllerName: EventListViewController.loadController())
    }
    @IBAction func filterBtnClicked(_ sender: Any) {
        let filterController = FiltersViewController.loadController()
        // Present View "Modally"
        self.present(filterController, animated: true, completion: nil)
        
    }
    @IBAction func makeReservationBtnClicked(_ sender: Any) {
        let filterController = MakeReservationsController.loadController()
        // Present View "Modally"
        self.present(filterController, animated: true, completion: nil)
    }
    func retrieveImagesforGooglePlaces ()
    {
        // Specify the place data types to return (in this case, just photos).
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue))
        
        let  placesClient = GMSPlacesClient()
        
        // let placesClient:GMSPlacesClient = ""
        placesClient.fetchPlace(fromPlaceID: "INSERT_PLACE_ID_HERE",
                                placeFields: fields,
                                sessionToken: nil, callback: {
            (place: GMSPlace?, error: Error?) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let place = place {
                // Get the metadata for the first photo in the place photo metadata list.
                let photoMetadata: GMSPlacePhotoMetadata = place.photos![0]
                
                // Call loadPlacePhoto to display the bitmap and attribution.
                placesClient.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
                    if let error = error {
                        // TODO: Handle the error.
                        print("Error loading photo metadata: \(error.localizedDescription)")
                        return
                    } else {
                        // Display the first image and its attributions.
                        //self.imageView?.image = photo;
                        // self.lblText?.attributedText = photoMetadata.attributions;
                    }
                })
            }
        })
    }
}
