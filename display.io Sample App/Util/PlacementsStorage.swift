//
//  PlacementsStorage.swift
//  display.io Sample App
//
//  Created by akrat on 8/6/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import Foundation
import DisplayIOFramework

class PlacementsStorage {
    
    private static let userPlacementsKey = "userPlacements"
    static let predefinedPlacements = [PlacementWrapper(id: "3353", name: "display.io Interstitial", type: "[Interstitial]", appId: "6552")]
    
    static func getUserDefinedPlacements() -> [PlacementWrapper] {
        let userDefaults = UserDefaults.standard
        if let decoded  = userDefaults.object(forKey: userPlacementsKey) as? Data {
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [PlacementWrapper]
            return decodedTeams ?? [PlacementWrapper]()
        } else {
            return [PlacementWrapper]()
        }
    }
    
    static func addNewPlacement(placementWrapper: PlacementWrapper?) {
        if let placement = placementWrapper {
            var placements = getUserDefinedPlacements()
            if !placements.contains(placement) {
                placements.append(placement)
                saveInUserDefaults(key: userPlacementsKey, value: placements)
            }
        } else {
            ///show error message here
        }
    }
    
    static func removePlacement(index: Int) {
        var placements = getUserDefinedPlacements()
        placements.remove(at: index)
        saveInUserDefaults(key: userPlacementsKey, value: placements)
    }
    
    private static func saveInUserDefaults(key: String, value: [PlacementWrapper]) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: value)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
}
