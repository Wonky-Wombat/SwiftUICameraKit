# SwiftUICameraKit

<p align="left">
    <img alt="Platform iOS" src="https://img.shields.io/badge/Platform-iOS%2014%2B-0A84FF">
    <img alt="Built with SwiftUI" src="https://img.shields.io/badge/UI-SwiftUI-0A84FF">
    <img alt="Swift Package Manager" src="https://img.shields.io/badge/SPM-supported-1f883d">
</p>

### A stable SwiftUI-based camera library for iOS.

## Acknowledgement

This project is forked from `https://github.com/bogdan/Camera.git`, which is based on the original **MijickCamera** work by **Mijick** and its contributors.

Original Github repo: `https://github.com/Mijick/Camera` <br />
Current fork repo: `https://github.com/bogdan/Camera`

## Features

- Automatic camera permission handling
- Photo capture
- Video capture, with optional audio
- Front and back camera switching
- Manual zoom and focus
- Adjustable frame rate and resolution
- Camera filters
- Torch and flash controls
- Exposure-related configuration including duration, target bias, ISO, and HDR
- Captured media flow and error presentation
- Customizable SwiftUI screens
- Gesture support
- Portrait orientation locking support

## Quick Start

### Installation

Add the package in Xcode using this repository URL:

`https://github.com/Wonky-Wombat/SwiftUICameraKit`

### Info.plist

Add these keys to your app's `Info.plist`:

- `NSCameraUsageDescription`
- `NSMicrophoneUsageDescription` if you want video recording with audio

### Presenting Camera

Basic usage:

```swift
import SwiftUI
import SwiftUICameraKit

struct ContentView: View {
    @State private var isCameraPresented = false

    var body: some View {
        (...)
        .fullScreenCover(isPresented: $isCameraPresented) {
            SwiftUICamera()
                .startSession()
        }
    }
}
```

Configured usage:

```swift
import SwiftUI
import SwiftUICameraKit

struct ContentView: View {
    @State private var isCameraPresented = false
    @State private var capturedImage: UIImage?

    var body: some View {
        (...)
        .fullScreenCover(isPresented: $isCameraPresented) {
            SwiftUICamera()
                .onImageCaptured { image, controller in
                    capturedImage = image
                    controller.closeMCamera()
                }
                .setCloseMCameraAction { isCameraPresented = false }
                .setCameraOutputType(.photo)
                .setAudioAvailability(false)
                .setCameraScreen { cameraManager, namespace, closeMCameraAction in
                    DefaultCameraScreen(
                        cameraManager: cameraManager,
                        namespace: namespace,
                        closeMCameraAction: closeMCameraAction
                    )
                    .cameraOutputSwitchAllowed(false)
                }
                .startSession()
        }
    }
}
```

## Package

- Product: `SwiftUICameraKit`
- Platforms: iOS 14+
- Swift tools: 6.0

## Structure

- `Sources/Public`: public API surface intended for package consumers
- `Sources/Internal`: camera manager, UI internals, assets, helpers, and extensions
- `Tests`: behavior-oriented tests around camera manager flows
