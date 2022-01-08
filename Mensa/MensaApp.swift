//
//  MensaApp.swift
//  Mensa
//
//  Created by Prof. Dr. Nunkesser, Robin on 06.01.22.
//

import SwiftUI

@main
struct MensaApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var environment = AppEnvironment()
    
    enum Keys : String {
        case status = "status_preference"
    }
    
    let userDefaults = UserDefaults.standard
    
    init() {
        registerDefaultsFromSettingsBundle()
    }
    
    func registerDefaultsFromSettingsBundle()
    {
        let plists = ["Root.plist"]
        for plist in plists {
            let settingsUrl = Bundle.main.url(forResource: "Settings",
                                              withExtension: "bundle")!
                .appendingPathComponent(plist)
            let settingsPlist = NSDictionary(contentsOf:settingsUrl)!
            let prefs = settingsPlist["PreferenceSpecifiers"] as! [NSDictionary]
            
            var defaultsToRegister = Dictionary<String, Any>()
            
            for preference in prefs {
                guard let key = preference["Key"] as? String else {
                    debugPrint("Key not found for \(preference["Title"] ?? "")")
                    continue
                }
                defaultsToRegister[key] = preference["DefaultValue"]
            }
            userDefaults.register(defaults: defaultsToRegister)
        }
    }
    
    func readStatus() {
        if let status = userDefaults.string(forKey: Keys.status.rawValue) {
            environment.status = Int(status)!
        }

    }
    
    var body: some Scene {
        WindowGroup {
            MensaView().environmentObject(environment)
        }.onChange(of: scenePhase) {
            switch $0 {
            case .active: readStatus()
            case .background, .inactive: break
            @unknown default: break
            }
        }

    }
}
