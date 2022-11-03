
import X11

struct EventLoop {
    func run(_ displayManager: inout DisplayManager) {
        while true {
            let event = getNextEvent(displayManager.displayPointer)
            
            switch event.type {
                case MapNotify:
                    handleMap(event.xmap)
                case UnmapNotify:
                    handleUnmap(event.xunmap)
                case EnterNotify:
                    print("Enter notify unhandled")
                    break // ???
                case LeaveNotify:
                    print("Leave notify unhandled")
                    break // ???
                case CreateNotify:
                    handleCreate(event.xcreatewindow)
                case DestroyNotify:
                    handleDestroy(event.xdestroywindow)
                case KeymapNotify:
                    handleKeymap(event.xkeymap)
                case MotionNotify:
                    handleMotion(event.xmotion)
                case GravityNotify:
                    handleGravity(event.xgravity)
                case MappingNotify:
                    handleMapping(event.xmapping)
                case ColormapNotify:
                    handleColormap(event.xcolormap)
                case PropertyNotify:
                    handleProperty(event.xproperty)
                case ReparentNotify:
                    handleReparent(event.xreparent)
                case CirculateNotify:
                    handleCirculate(event.xcirculate) // More of these?
                case ConfigureNotify:
                    handleConfigure(event.xconfigure) // More of these?
                case SelectionNotify:
                    handleSelection(event.xselection) // More of these?
                case VisibilityNotify:
                    handleVisibility(event.xvisibility)
                default:
                    print("Unknown event unhandled: \(event.type)")
            }
        }
    }
    private func handleMap(_ event: XMapEvent) {  }
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
    private func handleConfigure(_ event: XConfigureEvent) {  }
    private func handleSelection(_ event: XSelectionEvent) {  }
    private func handleVisibility(_ event: XVisibilityEvent) {  }
}

@inline(__always)
func getNextEvent(_ displayPointer: OpaquePointer) -> XEvent {
    var event: XEvent!
    XNextEvent(displayPointer, &event)
    return event
}