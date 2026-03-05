
# CheckButton

CheckButton is a custom checkbox package for SwiftUI making it easy to create simple checkboxes for iOS. CheckButton supports single and multiple choices.

## Requirements
* iOS 13.0+
* Xcode 11.2+
* wift 5.0
* SwiftUI framework

## Features
* Customizable checkbox view for SwiftUI.
* Customizable type, size and color of the checkbox.
* Customizable type, size and color of the checkmark.

## Installation
### Swift Package Manager

You can add CheckButton as a dependency in your Swift Package Manager-enabled project. Follow these steps to integrate the package into your project:
1. In Xcode, go to "File" -> "Add Packages...".
2. Enter the URL of this repository: [https://github.com/appostroph/CheckButton]
3. Choose the desired version rule.
4. Choose the target where you want to add the package.
5. Click "Add Package".
6. Wait till Xcode verify and fetch it for you.
7. Click "Add Package".

## Usage
To use CheckButton in your SwiftUI project, follow these steps:

1. Import the CheckButton module:
```swift
import CheckButton
```

2. Create an Enum containing the choices:
```swift
enum Gender: String, Choiceable {
    case male, female, diverse
    
    var id: Self { self }
    var title: String { return self.rawValue.capitalized }
}
```

3. Create a @State property to hold the selection:
```swift
@State private var gender: Gender? = nil
```

4. Create a CheckButtonConfig to hold the configuration of the CheckButton. Customize the buttons (size, color, single or multiple choices, etc…):
```swift
let radioConfig = CheckButtonConfig(
                shape: .circle,
                checkmarkType: .circle,
                multipleChoice: false,
                color: .secondary.opacity(0.4),
                borderColor: .secondary.opacity(0.6),
                markedBackground: .green)
```

5. Use the 'CheckButtonGroup' view in your SwiftUI view hierarchy:
```swift
CheckButtonGroup(items: Gender.self, config: radioConfig) { selections in
  gender = selections.first
}
```

**(See the example file in the repository for more use cases)**

## Author
Yasin Al-Hammadi, Senior Software Engineer.

## Contributing
Contributions to CheckButton are welcome! If you encounter any issues or have ideas for improvements, please feel free to open an issue or submit a pull request.

## License
CheckButton is available under the MIT License. See the LICENSE file for more information.
