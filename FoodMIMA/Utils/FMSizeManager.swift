//
//  FMSizeManager.swift
//  FoodMIMA
//  for setting horizontal, vertical, moderate scale and font size
//  Created by Johnson Olusegun on 2/20/23.
//

import Foundation

struct FMSizeManager {
    
    private let GUILD_LINE_BASE_WIDTH = 375.0;
    private let GUILD_LINE_BASE_HEIGHT = 812.0;
    private let width:Double;
    private let height:Double;
    
    
    init(withFrameWidth width: Double, withHeightWidth height:Double, withScale scale:Double = 1){
        self.width = width;
        self.height = height;
    }
    
    
    /// - Parameters: size:Double
    /// - Returns: size:Double
    /// - Description: For calculating width
    func horizontalScale (size: Double) -> Double {
        return (width / Double(GUILD_LINE_BASE_WIDTH)) * size;
    }
    
    /// - Parameters: size:Double
    /// - Returns: size:Double
    /// - Description: For calculating height
    func verticalScale (size: Double) -> Double {
        return (height / Double(GUILD_LINE_BASE_HEIGHT)) * size;
    }
    
    /// - Parameters: size and scaleFactor?
    /// - Returns: Double
    /// - Description: For  calculating border Radius, padding etc
    func moderateScale(size: Double, usingAScaleFactor scaleFactor:Double = 1) -> Double {
        return size + (horizontalScale(size:size) - size) * scaleFactor ;
    }
    
    
    /// - Parameters: size and scaleFactor?
    /// - Returns: Double
    /// - Description: For calculating font size
    func fontSize(size: Double, usingAScaleFactor scaleFactor:Double = 1) -> Double {
        return size + (horizontalScale(size:size) - size) * scaleFactor;
    }
    
    
    
}


