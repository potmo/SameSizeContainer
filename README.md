# SameSizeContainer

Make sure that views are the same width, height or both to allow for e.g. multi column text alignment.
They work in different part of the view hierarchy as long as they are all on screen at the same time

usage:
```swift
import SwiftUI
import SameSizeContainer

struct SomeView: View {
    
    // setup the groups. All views with the same group will have the same sizes
    @State private static let GROUP_BOTH_WIDTH_AND_HEIGHT = SizeGroup()
    @State private static let GROUP_ONLY_WIDTH = SizeGroup(resizing: .width)
    @State private static let GROUP_ONLY_HEIGHT = SizeGroup(resizing: .height)

    var body: some View {
    // The views in GROUP_BOTH_WIDTH_AND_HEIGHT has `.both` resizing so they will have the same width and height
        SameSize(group: Self.GROUP_BOTH_WIDTH_AND_HEIGHT) {
            Text("Short")
        }
        
        SameSize(group: Self.GROUP_BOTH_WIDTH_AND_HEIGHT) {
            Text("Very very long compared")
        }
        
        SameSize(group: Self.GROUP_BOTH_WIDTH_AND_HEIGHT) {
            Text("Two\nlines")
        }
        
        // These views will only have the same width, the height is dynamic as to the content
        SameSize(group: Self.GROUP_ONLY_WIDTH) {
            Text("Short")
        }
        
        SameSize(group: Self.GROUP_ONLY_WIDTH) {
            Text("Very long compared")
        }
        
        SameSize(group: Self.GROUP_ONLY_WIDTH) {
            Text("Line one\nLine two\nLine three")
        }
        
        // these view will have the same height but the width is dynamic
        SameSize(group: Self.GROUP_ONLY_HEIGHT) {
            Text("Short")
        }
        
        SameSize(group: Self.GROUP_ONLY_HEIGHT, alignment: .topLeading) {
            Text("A bit longer")
        }
        
        SameSize(group: Self.GROUP_ONLY_HEIGHT) {
            Text("Two\nlines")
        }
    }
}
```
