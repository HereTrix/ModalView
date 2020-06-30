# ModalNavigationView

SwiftUI implementation of modal presentation

## How to use
### Step 1
Add a dependency using Swift Package Manager to your project: [https://github.com/HereTrix/ModalView](https://github.com/HereTrix/ModalView)

#### Step 2
Import the dependency
```swift
import SwiftUIModalView
```
### Step 3
Use `ModalNavigationView` and `ModalNavigationLink` the same way you would use `NavigationView` and `NavigationLink`:

```swift
struct ContentView: View {
    var body: some View {
        ModalNavigationView {
            ModalNavigationLink(destination: SheetDetails(),
                                completion: {
            }) {
                Text("Show over current context")
            }
        }
    }
}
```
or use as `.sheet`
```swift
struct ContentView: View {

    @State var isPresenting = false

    var body: some View {
        Button(action: {
            self.isPresenting = true
        }) {
            Text("Modal with fullscreen")
                .present(isPresented: $isPresenting,
                     style: .fullScreen) { Text("Fullscreen presentation") }
        }
    }
}
```
## Additional information
For more details check example app
