//
//  CheckButtonView.swift
//
//
//  Created by Yasin Al-Hammadi on 17.04.24.
//

import SwiftUI

@available(iOS 13, *)
public struct CheckButtonGroup<T: Choiceable> : View where T.AllCases: RandomAccessCollection {
    
    private let items: T.Type
    private let config: CheckButtonConfig
    private let callback: ([T]) -> ()
    @State private var selections: [T]
    
    public init(items: T.Type,
                selections: [T] =  [T](),
                config: CheckButtonConfig,
                callback: @escaping ([T]) -> Void) {
        
        self.items = items
        self.selections = selections
        self.config = config
        self.callback = callback
    }
    
    public var body: some View {
        
        VStack {
            ForEach(items.allCases) { item in
                if config.multipleChoice {
                    CheckBox(id: item,
                             label: item.title,
                             config: config,
                             isMarked: selections.contains(item) ? true : false,
                             callback: checkBoxGroupCallback)
                } else {
                    RadioButton(id: item,
                                label: item.title,
                                config: config,
                                isMarked: selections.contains(item) ? true : false,
                                callback: radioGroupCallback)
                }
            }
        }
    }
    
    private func radioGroupCallback(id: T) {
        guard selections.contains(id) == false else { return }
        
        selections.removeAll()
        selections.append(id)
        callback(selections)
    }
    
    private func checkBoxGroupCallback(id: T, isMarked: Bool) {
        if isMarked {
            if selections.contains(id) == false {
                selections.append(id)
            }
        } else {
            if let index = selections.firstIndex(of: id) {
                selections.remove(at: index)
            }
        }
        
        callback(selections)
    }
}

@available(iOS 13, *)
internal struct RadioButton<T: Choiceable>: View where T.AllCases: RandomAccessCollection {
    
    private let id: T
    private let label: String
    private let config: CheckButtonConfig
    private let isMarked: Bool
    private let callback: (T)->()
    
    public init(id: T,
                label: String,
                config: CheckButtonConfig,
                isMarked: Bool,
                callback: @escaping (T)->()) {
        
        self.id = id
        self.label = label
        self.config = config
        self.isMarked = isMarked
        self.callback = callback
    }
    
    internal var body: some View {
        Button {
            callback(id)
        } label: {
            HStack(spacing: 10) {
                CheckButtonView(isMarked: isMarked, config: config)
                
                Text(label)
                    .font(config.font)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
        .animation(.smooth, value: isMarked)
    }
}

@available(iOS 13, *)
internal struct CheckBox<T: Choiceable>: View where T.AllCases: RandomAccessCollection {
    
    private let id: T
    private let label: String
    private let config: CheckButtonConfig
    private let callback: (T, Bool)->()
    @State private var isMarked: Bool
    
    public init(id: T,
                label:String,
                config: CheckButtonConfig,
                isMarked: Bool,
                callback: @escaping (T, Bool)->()) {
        
        self.id = id
        self.label = label
        self.config = config
        self.isMarked = isMarked
        self.callback = callback
    }
    
    internal var body: some View {
        Button {
            isMarked.toggle()
            callback(id, isMarked)
        } label: {
            HStack(spacing: 10) {
                CheckButtonView(isMarked: isMarked, config: config)
                
                Text(label)
                    .font(config.font)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
        .animation(.smooth, value: isMarked)
    }
}

@available(iOS 13, *)
internal struct CheckButtonView: View {
    
    private let isMarked: Bool
    private let config: CheckButtonConfig
    
    init(isMarked: Bool, config: CheckButtonConfig) {
        self.isMarked = isMarked
        self.config = config
    }
    
    internal var body: some View {
        Group {
            switch config.shape {
                case .circle: circleButton
                case .square: squareButton
            }
        }
        .overlay(
            Group {
                switch config.checkmarkType {
                    case .checkmark: checkmarkImage
                    case .circle: circleMark
                    case .square: squareMark
                }
            }
        )
    }
    
    // MARK: - Components
    
    @ViewBuilder
    private var squareButton: some View {
        let color = config.checkmarkType == .checkmark && isMarked ? config.markedBackground : config.color
        RoundedRectangle(cornerRadius: 3, style: .continuous)
            .frame(width: config.size, height: config.size)
            .foregroundColor(color)// isMarked ? config.markedBackground : config.color)
            .background(
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .stroke(isMarked ? config.markedBackground : config.borderColor, lineWidth: 1)
            )
    }
    
    @ViewBuilder
    private var circleButton: some View {
        let color = config.checkmarkType == .checkmark && isMarked ? config.markedBackground : config.color
        Circle()
            .frame(width: config.size, height: config.size)
            .foregroundColor(color)//isMarked ? config.markedBackground : config.color)
            .background(
                Circle()
                    .stroke(isMarked ? config.markedBackground : config.borderColor, lineWidth: 1)
            )
    }
    
    @ViewBuilder
    private var squareMark: some View {
        RoundedRectangle(cornerRadius: 3, style: .continuous)
            .frame(width: config.markSize, height: config.markSize)
            .foregroundColor(isMarked ? config.markedBackground : .clear)//config.color)
    }
    
    @ViewBuilder
    private var circleMark: some View {
        Circle()
            .frame(width: config.markSize, height: config.markSize)
            .foregroundColor(isMarked ? config.markedBackground : .clear)//config.color)
    }
    
    @ViewBuilder
    private var checkmarkImage: some View {
        Image(systemName: "checkmark")
            .resizable()
            .scaledToFit()
            .frame(width: config.markSize, height: config.markSize)
            .opacity(isMarked ? 1 : 0)
            .foregroundColor(config.markedForeground)
    }
}
