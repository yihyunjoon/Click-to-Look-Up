import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let eventMask = (1 << CGEventType.otherMouseDown.rawValue)

        guard let eventTap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: CGEventMask(eventMask),
            callback: { (proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, _) in
                switch type {
                case .otherMouseDown:
                    let mouseButtonNumber = event.getIntegerValueField(.mouseEventButtonNumber)
                    if (mouseButtonNumber == 2) {
                        let commandControlMask = (CGEventFlags.maskCommand.rawValue | CGEventFlags.maskControl.rawValue)
                        let commandControlMaskFlags = CGEventFlags(rawValue: commandControlMask) // cmd + ctrl
                        
                        let dDown = CGEvent(
                            keyboardEventSource: nil,
                            virtualKey: 0x02, // d
                            keyDown: true
                        )
                        dDown?.flags = commandControlMaskFlags // cmd + ctrl + d
                        
                        let dUp = CGEvent(
                            keyboardEventSource: nil,
                            virtualKey: 0x02, // d
                            keyDown: false
                        )
                        dUp?.flags = commandControlMaskFlags // cmd + ctrl + d
                        
                        dDown?.post(tap: CGEventTapLocation.cgSessionEventTap)
                        dUp?.post(tap: CGEventTapLocation.cgSessionEventTap)
                    }
                    
                default:
                    break
                }
                return Unmanaged.passRetained(event)
            },
            userInfo: nil
        ) else {
            fatalError("Failed to create event tap")
        }
        
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CGEvent.tapEnable(tap: eventTap, enable: true)
        CFRunLoopRun()
    }
}
