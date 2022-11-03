
import X11

struct EventLoop {
    func run(_ displayManager: inout DisplayManager) {
        while true {
            let event = getNextEvent(displayManager.displayPointer)
            
            switch event.type {
                case MapNotify:
                    break
                case UnmapNotify:
                    break
                case EnterNotify:
                    break
                case LeaveNotify:
                    break
                case CreateNotify:
                    break
                case DestroyNotify:
                    break
                case KeymapNotify:
                    break
                case MotionNotify:
                    break
                case GravityNotify:
                    break
                case MappingNotify:
                    break
                case ColormapNotify:
                    break
                case PropertyNotify:
                    break
                case ReparentNotify:
                    break
                case CirculateNotify:
                    break
                case ConfigureNotify:
                    break
                case SelectionNotify:
                    break
                case VisibilityNotify:
                    break
                default:
                    print("Unknown event unhandled: \(event)")
            }
        }
    }
}

@inline(__always)
func getNextEvent(_ displayPointer: OpaquePointer) -> XEvent {
    var event: XEvent!
    XNextEvent(displayPointer, &event)
    return event
}