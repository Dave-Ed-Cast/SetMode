# SetMode

Welcome to the repository that demonstrates an advanced and scalable method for managing multiple **windows** and **immersive spaces** in a **visionOS** application, using a unified `setMode` function!

> **Note:** This approach ensures that transitions between different app states are smooth, scalable, and maintainable — essential for real-world spatial computing apps.

---

## 🚀 What This Project Covers

- **Unified Navigation:** Easily open/close windows and immersive spaces with a single operation.
- **Custom Environment Key:** Introduces a `setMode` environment value available throughout the app.
- **Dynamic Flow Handling:** Supports both simple and complex application flows.
- **Full Support for Spatial Computing:** Manage multiple simultaneous elements if needed.
- **Concurrency Safe:** Designed with Swift 6 concurrency features in mind.

---

## 📋 Setup Overview

1. **Define a Custom Environment Key (`setMode`)**
   - Injects a function to change modes across the entire app.

2. **Static Window and Space Identifiers**
   - Centralized in a `WindowIDs` struct for maintainability.

3. **Mode Enum**
   - Represents all possible app states (windows or immersive spaces).
   - Includes helper computed properties to manage state behavior.

4. **App Scene Injection**
   - Injects `setMode` into every view by wrapping the windows into a `Group`.

5. **Smart setMode Function**
   - Handles opening, closing, and overlapping windows, as well as immersive space transitions.
   - Manages `@State` values such as `mode`, `immersiveSpacePresented`, and `overlappingWindows`.

---

## 🧩 Example Usage

```swift
struct WelcomeView: View {
    @Environment(\.setMode) private var setMode

    var body: some View {
        Button("Go to main screen") {
            Task { await setMode(.mainScreen) }
        }
    }
}
```

## 🎯 Why Use This?

✅ **Scalability:** Add whatever new window or immerive space target, just change your algorithm!  
✅ **Maintainability:** One centralized way to manage window/immersive transitions.  
✅ **VisionOS Best Practices:** Designed with spatial computing's multi-window nature in mind.  
✅ **Concurrency Safety:** Designed to also work with Swift 6 strict concurrency.

---

## 📸 Demo

![ezgif-84321b3a5ae0de](https://github.com/user-attachments/assets/e6f3a2a0-e963-4321-a0e9-14e082e34f9e)

---

## 🧰 Related Projects

- **[VisionTextArc](https://github.com/Dave-Ed-Cast/VisionTextArc)** — Create beautiful 3D curved text in visionOS!

---

## 🙌 Contributing

Feel free to fork this project, open issues, and make pull requests!  
Let's build better spatial computing apps together.

---

## 🔗 Resources

- [Apple visionOS Documentation](https://developer.apple.com/visionos/)
- [Swift Concurrency Best Practices](https://swift.org/documentation/concurrency/)
