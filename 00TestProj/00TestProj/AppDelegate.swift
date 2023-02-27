//
//  AppDelegate.swift
//  00TestProj
//
//  Created by Александр Фофонов on 26.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum UserDefaultStorageKeys: String {
        case lastSessionDate = "last session date"
        case profile = "profile"
        case city = "city"
    }
    
    let assembly = Assembly()
    lazy var dataStorage = assembly.dataStorage
    lazy var apiClient = assembly.apiClient
    lazy var bootstrapDataProvider = assembly.bootstrapDataProvider
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        bootstrapDataProvider.loadData { result in
            self.dataStorage.save(value: result.profile, key: UserDefaultStorageKeys.profile)
            self.dataStorage.save(value: result.city, key: UserDefaultStorageKeys.city)
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    
    }

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

}
