//
//  FoodOrderingApp.swift
//  FoodOrdering
//
//  Created by Altamis Hail Ahsan Nasution on 01/03/21.
//

import SwiftUI
import Firebase

@UIApplicationMain
struct FoodOrderingApp: App {
    @UIApplicationDelegateAdaptor
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchWithOptions launchOption:
        [UIApplication.LaunchOptionsKey : Any]? = nil)-> Bool{
        FirebaseApp.configure()
        return true
    }
}
