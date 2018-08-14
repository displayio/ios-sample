//
//  StaticValues.swift
//  display.io Sample App
//
//  Created by akrat on 7/25/18.
//  Copyright © 2018 akrat. All rights reserved.
//

class StringConstants {
    static let pageTitle = "display.io Sample app"
    static let predefinedPlacementsTitle = "display.io Pre-Defined Placements"
    static let userDefinedPlacementsTitle = "My Placements"
    
    static let adsKey = "ads"
    static let adKey = "ad"
    static let typeKey = "type"
    static let noFillKey = "noFill"
    
    static let okKey = "OK"
    
    static let messageAdWasLoaded = "Ad was loaded"
    static let messageAdIsLoading = "Ad is loading"
    
    static let errAppIdIsNotDefined = "App ID is not defined"
    static let errAppIdIsTooShort = "App ID must contain at least two numbers"
    static let errAppInactive = "App is inactive"
    static let errNoFill = "No fill"
    
    static let dialogTitleRemovePlacement = "Remove placement"
    static let dialogMessageRemovePlacement = "Are you sure you want to remove \"%@\" placement?"
    static let dialogButtonRemovePlacementRemove = "Remove"
    static let dialogButtonRemovePlacementCancel = "Cancel"
    
    static let adTypes = ["interstitial" : "[Interstitial]", noFillKey : "No fill"]
}

class ColorScheme {
    static let colorPrimary = "2C3E50"
    static let colorAccent = "1ABC9C"
    static let colorBody = "edf0f1"
    static let colorLightGrey = "bdc3c7"
    static let colorDarkGrey = "7f8c8d"
    static let colorLightRed = "C34A4A"
    static let colorLightGreen = "8BC34A"
    static let colorLightBlue = "4080D8"
}

class FontScheme {
    static let MontserratLight = "Montserrat-Light"
    static let MontserratMedium = "Montserrat-Medium"
    static let MontserratRegular = "Montserrat-Regular"
    static let MontserratThin = "Montserrat-Thin"
}
