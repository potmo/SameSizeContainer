# SameSizeContainer

Make sure that views are the same width, height or both to allow for e.g. multi column text alignment.
They work in different part of the view hierarchy as long as they are all on screen at the same time

This works by adding the contained view in a `ZStack` and measuring it's size. Then an invisible view is also added to the `ZStack` with the max size of all contained views in the same group effectively resizing all views in the same group to the same size.

A group can be greated with `SizeGroup(resizing: .width)`, `SizeGroup(resizing: .height)` or `SizeGroup(resizing: .both)` affecting the width, height or both.


usage:

![Screenshot](/screenshot2.png)

```swift
import SwiftUI
import SameSizeContainer

struct SomeView: View {
    
    @State private var TITLE_GROUP = SizeGroup(resizing: .width)
    @State private var ELEMENT_GROUP = SizeGroup(resizing: .width)
    @State private var MULTI_LINE_HEIGHT = SizeGroup(resizing: .height)
    @State private var SINGLE_LINE_HEIGHT = SizeGroup(resizing: .height)
    
    @State private var name: String = "Some name"
    @State private var adress: String = "Street 1\n123 45\nCity\nCountry"
    @State private var age: Int = 20
    
    var body: some View {
        HStack {
            VStack {
                SameSize(group: SINGLE_LINE_HEIGHT, alignment: .center) {
                    SameSize(group: TITLE_GROUP, alignment: .trailing) {
                        Text("Name")
                    }
                }
                
                SameSize(group: MULTI_LINE_HEIGHT, alignment: .topLeading) {
                    SameSize(group: TITLE_GROUP, alignment: .trailing) {
                        Text("Adress")
                    }
                }
                
                SameSize(group: SINGLE_LINE_HEIGHT, alignment: .center) {
                    SameSize(group: TITLE_GROUP, alignment: .trailing) {
                        Text("Age")
                    }
                }
            }
            
            VStack(alignment: .leading) {
                SameSize(group: SINGLE_LINE_HEIGHT, alignment: .center) {
                    SameSize(group: ELEMENT_GROUP, alignment: .leading) {
                        TextField("", text: $name)
                            .labelsHidden()
                    }
                }
                SameSize(group: MULTI_LINE_HEIGHT, alignment: .topLeading) {
                    SameSize(group: ELEMENT_GROUP, alignment: .topLeading) {
                        TextField("", text: $adress)
                            .labelsHidden()
                    }
                }
                SameSize(group: SINGLE_LINE_HEIGHT, alignment: .center) {
                    SameSize(group: ELEMENT_GROUP, alignment: .leading) {
                        Picker("", selection: $age) {
                            ForEach(18..<99) { age in
                                Text("\(age)").tag(age)
                            }
                        }
                        .labelsHidden()
                        .frame(width: 60)
                    }.pickerStyle(PopUpButtonPickerStyle())
                }
                
            }
        }.padding()
        
    }
}
```

Showing the outlines of the views:

![Screenshot](/screenshot.png)

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
