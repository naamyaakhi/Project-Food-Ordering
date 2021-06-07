//
//  HomeViewModel.swift
//  FoodOrdering
//
//  Created by Altamis Hail Ahsan Nasution on 01/03/21.
//

import SwiftUI
import CoreLocation
import Firebase

class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
   @Published var locationManager = CLLocationManager()
   @Published var search = ""
   
   @Published var userLocation: CLLocation!
   @Published var userAddress = ""
   @Published var noLocation = false
   
   @Published var showMenu = false
   
    @Published var items : [Item] = []
    @Published var filtered : [Item] = []
   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      switch manager.authorizationStatus {
      case .authorizedWhenInUse:
         print("authorized")
         self.noLocation = false
         manager.requestLocation()
      case .denied:
         print("denied")
         self.noLocation = true
      default:
         print("unknown")
         self.noLocation = false
         locationManager.requestWhenInUseAuthorization()
         
      }
   }
   
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(error.localizedDescription)
   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      self.userLocation = locations.last
      self.extractLocation()
   }
   
   func extractLocation() {
      CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
         guard let safeData = res else {return}
         
         var address = ""
         
         address += safeData.first?.name ?? ""  //nil colascing
         address += ", "
         address += safeData.first?.locality ?? ""
         
         self.userAddress = address
      }
   }
   
    func login() {
        Auth.auth().signInAnonymously {(res, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")
            
            self.fetchData()
        }
    }
   
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments{ (snap ,err ) in
            guard let itemData = snap else {return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_image: image, item_ratings: ratings, item_details: details)
            })
        }
    }
    
    func filterData() {
        withAnimation(.linear) {
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
}

// class NSObject = kelas yang mendeklarasikan sebagai objective - c
//NSObject = sebuah kelas turunan,yang mana NSObject berasal dari bahasa objective-c

//CLLocationManagerDelegate = Delegasi dari library CoreLocation
//CorelocationManager = meng update lokasi terkini
//CoreLocation = membaca latitude longitude sebuah daerah/lokasi
//CLGeocoder = yang mengubah sebuah alamat menjadi latitude longitude
