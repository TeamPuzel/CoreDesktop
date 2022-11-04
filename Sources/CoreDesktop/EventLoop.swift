
import X11

struct EventLoop {
    func run(_ displayManager: inout DisplayManager) {
        while true {
            let event = getNextEvent(displayManager.displayPointer)
            
            switch event.type {
                case ConfigureRequest:
                    handleConfigureRequest(event.xconfigurerequest, &displayManager)
                case MapRequest:
                    handleMapRequest(event.xmaprequest, &displayManager)
                default:
                    print("Unsupported event not handled: \(event.type)")
            }
        }
    }
    
    // Configure a window as requested
    private func handleConfigureRequest(_ event: XConfigureRequestEvent, _ displayManager: inout DisplayManager) { 
        var windowChanges = XWindowChanges(
            x: event.x, y: event.y, 
            width: event.width, height: event.height, 
            border_width: event.border_width, sibling: event.window, 
            stack_mode: event.detail)
        XConfigureWindow(displayManager.displayPointer, event.window, UInt32(event.value_mask), &windowChanges)
    }
    
    // Create window decorations
    private func handleMapRequest(_ event: XMapRequestEvent, _ displayManager: inout DisplayManager) { 
        decorateWindow(event.window, &displayManager)
        XMapWindow(displayManager.displayPointer, event.window)
    }
    static let BORDER_WIDTH = 1
    static let 
    private func decorateWindow(_ window: Window, _ displayManager: inout DisplayManager) {
        var windowAttributes: XWindowAttributes!
        XGetWindowAttributes(displayManager.displayPointer, window, &windowAttributes)
        
        let windowFrame = XCreateSimpleWindow(
            displayManager.displayPointer, displayManager.rootWindow, 
            windowAttributes.x, windowAttributes.y,
            UInt32(windowAttributes.width), UInt32(windowAttributes.height),
            UInt32, UInt, UInt)
    }
    
    private func handleUnmap(_ event: XUnmapEvent) {  }
    private func handleEnter(_ event: XEnterWindowEvent) {  }
    private func handleLeave(_ event: XLeaveWindowEvent) {  }
    private func handleCreate(_ event: XCreateWindowEvent) {  }
    private func handleDestroy(_ event: XDestroyWindowEvent) {  }
    private func handleKeymap(_ event: XKeymapEvent) {  }
    private func handleMotion(_ event: XMotionEvent) {  }
    private func handleGravity(_ event: XGravityEvent) {  }
    private func handleMapping(_ event: XMappingEvent) {  }
    private func handleColormap(_ event: XColormapEvent) {  }
    private func handleProperty(_ event: XPropertyEvent) {  }
    private func handleReparent(_ event: XReparentEvent) {  }
    private func handleCirculate(_ event: XCirculateEvent) {  }
    private func handleSelection(_ event: XSelectionEvent) {  }
    private func handleVisibility(_ event: XVisibilityEvent) {  }
}

@inline(__always)
func getNextEvent(_ displayPointer: OpaquePointer) -> XEvent {
    var event: XEvent!
    XNextEvent(displayPointer, &event)
    return event
}