
import X11

struct EventLoop {
    var clientWindows: [Window] = []
    
    mutating func run(_ displayManager: inout DisplayManager) {
        while true {
            let event = getNextEvent(displayManager.displayPointer)
            
            switch event.type {
                case ConfigureRequest:
                    handleConfigureRequest(event.xconfigurerequest, &displayManager)
                case MapRequest:
                    handleMapRequest(event.xmaprequest, &displayManager)
                case UnmapNotify:
                    handleUnmapNotify(event.xunmap, &displayManager)
                case ReparentNotify:
                    break
                case DestroyNotify:
                    break
                default:
                    break
                    // print("Unsupported event not handled: \(event.type)")
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
    private mutating func handleMapRequest(_ event: XMapRequestEvent, _ displayManager: inout DisplayManager) { 
        decorateWindow(event.window, &displayManager)
        XMapWindow(displayManager.displayPointer, event.window)
    }
    let FRAME_BORDER_WIDTH: UInt32 = 1
    let FRAME_BORDER_COLOR: UInt = 0xffffff
    let FRAME_BG_COLOR: UInt = 0x000000
    private mutating func decorateWindow(_ window: Window, _ displayManager: inout DisplayManager) {
        var windowAttributes: XWindowAttributes!
        XGetWindowAttributes(displayManager.displayPointer, window, &windowAttributes)
        
        let windowFrame = XCreateSimpleWindow(
            displayManager.displayPointer, displayManager.rootWindow, 
            windowAttributes.x, windowAttributes.y,
            UInt32(windowAttributes.width), UInt32(windowAttributes.height),
            FRAME_BORDER_WIDTH, FRAME_BORDER_COLOR, FRAME_BG_COLOR)
            
        XSelectInput(displayManager.displayPointer, windowFrame, SubstructureRedirectMask | SubstructureNotifyMask)
        XAddToSaveSet(displayManager.displayPointer, window)
        XReparentWindow(displayManager.displayPointer, window, windowFrame, 0, 0)
        XMapWindow(displayManager.displayPointer, windowFrame)
        clientWindows.append(windowFrame)
    }
    
    private mutating func handleUnmapNotify(_ event: XUnmapEvent, _ displayManager: inout DisplayManager) {
        if clientWindows.contains(event.window) {
            XUnmapWindow(displayManager.displayPointer, clientWindows[Int(event.window)])
            XReparentWindow(displayManager.displayPointer, event.window, displayManager.rootWindow, 0, 0)
            XRemoveFromSaveSet(displayManager.displayPointer, event.window)
            XDestroyWindow(displayManager.displayPointer, clientWindows[Int(event.window)])
            let index = clientWindows.firstIndex(of: event.window)
            clientWindows.remove(at: index!)
        }
    }
}

@inline(__always)
func getNextEvent(_ displayPointer: OpaquePointer) -> XEvent {
    var event: XEvent!
    XNextEvent(displayPointer, &event)
    return event
}