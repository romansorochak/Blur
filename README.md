# Blur
- Simple approach to apply blur effect to UIView or it's sublasses.

|             Dark                |           Light                 |          Extra light            |
|---------------------------------|---------------------------------|---------------------------------|
|![Demo](https://github.com/romansorochak/Blur/blob/master/Blur/blur_dark.jpg)|![Demo](https://github.com/romansorochak/Blur/blob/master/Blur/blur_light.jpg)|![Demo](https://github.com/romansorochak/Blur/blob/master/Blur/blur_extra_light.jpg)|

## Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)


## Requirements

- iOS 8.0+
- Swift 3.0+

## Installation
All logic is in [UIView+Blur.swift](https://github.com/romansorochak/Blur/blob/master/Blur/UIView%2BBlur.swift) file.
Just copy this [file](https://github.com/romansorochak/Blur/blob/master/Blur/UIView%2BBlur.swift) to your project.


# Usage
```swift 
imageView.applyBlurEffect(
  style: UIBlurEffectStyle.light,
  enableVibrancy: true,
  blurAlpha: 0.9
)
```

## License

Reusable is released under the MIT license. See [LICENSE](https://github.com/romansorochak/Blur/blob/master/LICENSE) for details.
