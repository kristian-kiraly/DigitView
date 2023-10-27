# DigitView

A simple SwiftUI view that will render a number digit in the style of a classic gym scoreboard display.

DigitView Usage:
```swift
struct ContentView: View {
    var body: some View {
        HStack {
            DigitView(digit: "2", color: .red, offColor: .red.opacity(0.2))
            DigitView(digit: "5", color: .red, offColor: .red.opacity(0.2))
        }
    }
}
```
