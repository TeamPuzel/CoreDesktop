
import X11

@main
public struct Main {
    public static func main() {
        // Create the display manager, starting the session
        var displayManager = DisplayManager()
        displayManager.tryBecomeManager()
        
        // Start the event loop
        var eventLoop = EventLoop()
        eventLoop.run(&displayManager)
        
        // End the session
        displayManager.end()
    }
}

struct DisplayManager {
    let displayPointer: OpaquePointer
    let rootWindow: Window
    init() { displayPointer = XOpenDisplay(nil); rootWindow = XDefaultRootWindow(displayPointer) }
    
    func tryBecomeManager() { XSetErrorHandler(badAccessHandler)
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

func errorHandler(displayPointer: OpaquePointer?, errorEventPointer: UnsafeMutablePointer<XErrorEvent>?) -> Int32 { 
    if errorEventPointer!.pointee.error_code == BadAtom {
        XCloseDisplay(displayPointer)
        fatalError("BadAtom")
    }
    if errorEventPointer!.pointee.error_code == BadColor {
        XCloseDisplay(displayPointer)
        fatalError("BadColor")
    }
    if errorEventPointer!.pointee.error_code == BadCursor {
        XCloseDisplay(displayPointer)
        fatalError("BadCursor")
    }
    if errorEventPointer!.pointee.error_code == BadDrawable {
        XCloseDisplay(displayPointer)
        fatalError("BadDrawable")
    }
    if errorEventPointer!.pointee.error_code == BadFont {
        XCloseDisplay(displayPointer)
        fatalError("BadFont")
    }
    if errorEventPointer!.pointee.error_code == BadGC {
        XCloseDisplay(displayPointer)
        fatalError("BadGC")
    }
    if errorEventPointer!.pointee.error_code == BadIDChoice {
        XCloseDisplay(displayPointer)
        fatalError("BadIDChoice")
    }
    if errorEventPointer!.pointee.error_code == BadImplementation {
        XCloseDisplay(displayPointer)
        fatalError("BadImplementation")
    }
    if errorEventPointer!.pointee.error_code == BadLength {
        XCloseDisplay(displayPointer)
        fatalError("BadLength")
    }
    if errorEventPointer!.pointee.error_code == BadMatch {
        XCloseDisplay(displayPointer)
        fatalError("BadMatch")
    }
    if errorEventPointer!.pointee.error_code == BadName {
        XCloseDisplay(displayPointer)
        fatalError("BadName")
    }
    if errorEventPointer!.pointee.error_code == BadPixmap {
        XCloseDisplay(displayPointer)
        fatalError("BadPixmap")
    }
    if errorEventPointer!.pointee.error_code == BadRequest {
        XCloseDisplay(displayPointer)
        fatalError("BadRequest")
    }
    if errorEventPointer!.pointee.error_code == BadValue {
        XCloseDisplay(displayPointer)
        fatalError("BadValue")
    }
    return 0
}
