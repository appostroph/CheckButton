//
//  CheckButtonModel.swift
//
//
//  Created by Yasin Al-Hammadi on 17.04.24.
//

import SwiftUI

@available(iOS 13, *)
public protocol Choiceable: CaseIterable, Identifiable, Hashable, Codable {
    var id: Self { get }
    var title: String { get }
}

@available(iOS 13, *)
public enum CheckButtonShape {
    case circle, square
}

@available(iOS 13, *)
public enum CheckmarkType {
    case checkmark, circle, square
}

@available(iOS 13, *)
public struct CheckButtonConfig {
    
    let shape: CheckButtonShape
    let checkmarkType: CheckmarkType
    let multipleChoice: Bool
    let font: Font
    let size: CGFloat
    let markSize: CGFloat
    let color: Color
    let borderColor: Color
    let markedBackground: Color
    let markedForeground: Color
    
    public init(shape: CheckButtonShape,
                checkmarkType: CheckmarkType,
                multipleChoice: Bool,
                font: Font = .body,
                size: CGFloat = 20,
                markSize: CGFloat = 16,
                color: Color = .white,
                borderColor: Color = .gray,
                markedBackground: Color = .blue,
                markedForeground: Color = .white) {
        
        self.shape = shape
        self.checkmarkType = checkmarkType
        self.multipleChoice = multipleChoice
        self.font = font
        self.size = size
        self.markSize = markSize
        self.color = color
        self.borderColor = borderColor
        self.markedBackground = markedBackground
        self.markedForeground = markedForeground
    }
}
