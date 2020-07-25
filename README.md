# SameSizeContainer

Make sure that views are the same width, height or both to allow for e.g. multi column text alignment.
They work in different part of the view hierarchy as long as they are all on screen at the same time

usage:
```swift
import SwiftUI
import SameSizeContainer

struct SomeView: View {
    
    // setup the groups. All views with the same group will have the same sizes

    @State private var TITLE_GROUP = SizeGroup(resizing: .width)
    @State private var ELEMENT_GROUP = SizeGroup(resizing: .both)
    
    var body: some View {
        HStack {
            VStack {
                SameSize(group: TITLE_GROUP, alignment: .trailing) {
                    Text("One thing")
                        .background(Color.purple.opacity(0.2))
                }
                .border(Color.blue, width: 1)
                
                SameSize(group: TITLE_GROUP, alignment: .trailing) {
                    Text("Other thing")
                        .background(Color.purple.opacity(0.2))
                }
                .border(Color.blue, width: 1)
                
                SameSize(group: TITLE_GROUP, alignment: .trailing) {
                    Text("A Third thing")
                        .background(Color.purple.opacity(0.2))
                }
                .border(Color.blue, width: 1)
            }
            .border(Color.red, width: 1)
            .padding()
            
            VStack(alignment: .leading) {
                Text("This is not in a group")
                Text("This is not either")
                Text("And not this")
            }
            .border(Color.red, width: 1)
            .padding()
            
            VStack(alignment: .leading) {
                SameSize(group: ELEMENT_GROUP, alignment: .topLeading) {
                    Text("A Short")
                        .background(Color.purple.opacity(0.2))
                }
                .border(Color.blue, width: 1)
                
                SameSize(group: ELEMENT_GROUP, alignment: .topLeading) {
                    Text("A Longer one")
                        .background(Color.purple.opacity(0.2))
                }
                .border(Color.blue, width: 1)
                
                SameSize(group: ELEMENT_GROUP, alignment: .topLeading) {
                    Text("Another one\nthat is multiline so it makes all be taller")
                        .background(Color.purple.opacity(0.2))
                }
                .border(Color.blue, width: 1)
                
            }
            .border(Color.red, width: 1)
            .padding()
        }
        .border(Color.green, width: 1)
        .padding()
        
    }
}

struct SameSizeExample_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
```
