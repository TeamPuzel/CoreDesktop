
import X11

@main
public struct Main {
    public static func main() {
        // Create the display manager, starting the session
        let displayManager = DisplayManager()
        displayManager.becomeManager()
        
        
        // End the session
        displayManager.end()
    }
}

struct DisplayManager {
    private let displayPointer: OpaquePointer
    let rootWindow: Window
    init() { displayPointer = XOpenDisplay(nil); rootWindow = XDefaultRootWindow(displayPointer) }
    
    func becomeManager() { XSetErrorHandler(badAccessHandler)
        XSelectInput(displayPointer, rootWindow, SubstructureRedirectMask | SubstructureNotifyMask)
        XSync(displayPointer, 0)
    }
    
    func end() { XCloseDisplay(displayPointer) }
}

func badAccessHandler(displayPointer: OpaquePointer?, errorEventPointer: UnsafeMutablePointer<XErrorEvent>?) -> Int32 { 
    if errorEventPointer!.pointee.error_code == BadAccess {
        XCloseDisplay(displayPointer)
        fatalError("A window manager is already running.")
    }
    return 0
}