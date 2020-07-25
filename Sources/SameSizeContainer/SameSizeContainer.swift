import SwiftUI

fileprivate extension Color {
    func exec(block: @escaping ()->Void) -> Self {
        block()
        return self
    }
}

fileprivate class Deiniter {
    let block: ()->Void
    init(block: @escaping ()->Void) {
        self.block = block
    }
    deinit {
        block()
    }
}
public struct SameSize<Content: View>: View {
    private var id: UUID
    private let deiniter: Deiniter
    @ObservedObject private var group: SizeGroup
    private var content: () -> Content
    private let alignment: Alignment
    
    init(group: SizeGroup, alignment: Alignment = .center, @ViewBuilder content: @escaping ()-> Content) {
        self.group = group
        self.content = content
        self.alignment = alignment
        
        let id = UUID()
        self.id = id
        
        
        SizeGroup.sizes[group.id]?[id] = .zero
        self.deiniter = Deiniter() {
            SizeGroup.sizes[group.id]?.removeValue(forKey: id)
        }
    }
    
    @ViewBuilder
    public var body: some View {
        ZStack(alignment: self.alignment) {
            Rectangle()
                .frame(width: self.group.size.width, height: self.group.size.height)
                .foregroundColor(.clear)
            
            content()
                .overlay(
                    GeometryReader { proxy in
                        Color.clear
                            .exec {
                                SizeGroup.sizes[self.group.id]?[self.id] = proxy.size
                                
                                let newWidth = SizeGroup.sizes[group.id]?.values.map{$0.width}.max() ?? 0
                                let newHeight = SizeGroup.sizes[group.id]?.values.map{$0.height}.max() ?? 0
                                
                                var newSize = CGSize.zero
                                
                                switch group.resizing {
                                    case .width:
                                        newSize.width = newWidth
                                    case .height:
                                        newSize.height = newHeight
                                    case .both:
                                        newSize.width = newWidth
                                        newSize.height = newHeight
                                }
                                
                                if newSize != self.group.size {
                                    self.group.size = newSize
                                }
                            }
                    }
                )
        }
    }
}

public class SizeGroup: ObservableObject {
    
    static var sizes: [UUID: [UUID: CGSize]] = [:]
    
    @Published fileprivate var size: CGSize = .zero
    
    fileprivate let id: UUID
    fileprivate let resizing: Resizing
    
    public init(resizing: Resizing = .both) {
        let id = UUID()
        self.id = id
        self.resizing = resizing
        
        SizeGroup.sizes[id] = [:]
    }
    
    deinit {
        SizeGroup.sizes.removeValue(forKey: id)
    }
    
    public enum Resizing {
        case height
        case width
        case both
    }
}



struct SameSize_Previews: PreviewProvider {
    
    private static let GROUP1 = SizeGroup()
    private static let GROUP2 = SizeGroup()
    private static let GROUP_ONLY_WIDTH = SizeGroup(resizing: .width)
    private static let GROUP_ONLY_HEIGHT = SizeGroup(resizing: .height)
    
    static var previews: some View {
        Group {
            SameSize(group: Self.GROUP1) {
                Text("Short")
            }
            
            SameSize(group: Self.GROUP1) {
                Text("Very very long compared")
            }
            
            SameSize(group: Self.GROUP1) {
                Text("Two\nlines")
            }
            
            SameSize(group: Self.GROUP_ONLY_WIDTH) {
                Text("Short")
            }
            
            SameSize(group: Self.GROUP_ONLY_WIDTH) {
                Text("Very long compared")
            }
            
            SameSize(group: Self.GROUP_ONLY_WIDTH) {
                Text("Line one\nLine two\nLine three")
            }
            
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
}
