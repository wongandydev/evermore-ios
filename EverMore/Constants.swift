//
//  Constants.swift
//  EverMore
//
//  Created by Andy Wong on 5/2/20.
//  Copyright © 2020 Andy Wong. All rights reserved.
//

import UIKit

struct Constants {
    static var inDevelopment: Bool {
        guard let inDevelopment = Bundle.main.infoDictionary?["IN_DEVELOPMENT"] as? String else {
            return true
        }
        
        return inDevelopment == "YES"
    }
    
    static var bannerAdUnitId = inDevelopment ? "ca-app-pub-3940256099942544/2934735716":"ca-app-pub-4388758752901980/7907334743"
    static var InterstitialAdUnitId = inDevelopment ? "ca-app-pub-3940256099942544/4411468910" : "ca-app-pub-4388758752901980/8753512559"
    
    static let statusBarHeight                  = UIApplication.shared.statusBarFrame.height
    static let navigationBarHeight              = CGFloat(44.0)
    static let navigationBarLargeTitlesHeight   = CGFloat(96.0)
    static let tabBarHeight                     = CGFloat(49.0) + CGFloat(UIApplication.shared.windows[0].safeAreaInsets.bottom)
    
    static let screenHeight     = UIScreen.main.bounds.height
    static let screenWidth      = UIScreen.main.bounds.width
    
    static var topPadding       = CGFloat(UIApplication.shared.windows[0].safeAreaInsets.top)
    static var bottomPadding    = CGFloat(UIApplication.shared.windows[0].safeAreaInsets.bottom)
    static var safeAreaHeight   = screenHeight - topPadding - bottomPadding
    
    static let pixelWidth       = screenWidth * UIScreen.main.scale
    static let pixelHeight      = screenHeight * UIScreen.main.scale

    static let verticalScale = 1/(734.0/Constants.safeAreaHeight)
    
    static let typeScale: CGFloat = {
        if screenWidth < 375.0  { return 320.0/375.0 }     // iPhone 5/5S/5SE
        if screenWidth >= 414.0 { return 414.0/375.0 }     // iPhone 6+/7+/8+, XR, Xs Max
        return 1.0                                         // iPhone 6/7/8/X/Xs
    }()
    
    static let smallScreenTypeScale: CGFloat = {
        if screenWidth < 375.0  { return 320.0/375.0 }     // iPhone 5/5S/5SE
        return 1.0                                         // all others
    }()
    
    // Buttons
    static var defaultBoxButtonHeight: CGFloat {
        if (50*Constants.typeScale > 50.0) { return 50.0 }
        else { return 50.0*Constants.typeScale }
    }
    
    // UserDefault keys
    
    static let defaultBudget = "budget"
    static let defaultScreenerCompleted = "screenerCompleted"
    static let defaultTutorialCompleted = "tutorialCompleted"
}
