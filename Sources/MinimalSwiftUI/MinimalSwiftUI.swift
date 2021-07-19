import Foundation
import SwiftUI
import Cocoa

// code below was modified from 
// https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff

public extension NSApplication
{
  func run<V: View>(@ViewBuilder view: () -> V)
  {
    let appDelegate = AppDelegate(view())
    NSApp.setActivationPolicy(.regular)
    mainMenu = customMenu
    delegate = appDelegate
    run()
  }
}

open class AppDelegate<V: View>: NSObject, NSApplicationDelegate, NSWindowDelegate
{
  public init(_ contentView: V)
  {
    self.contentView = contentView
  }
  public var window: NSWindow!
  public var hostingView: NSView?
  public var contentView: V
   
  public func applicationDidFinishLaunching(_ notification: Notification)
  {
    window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                      styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                      backing: .buffered, defer: false)
    window.center()
    window.setFrameAutosaveName("Main Window")
    hostingView = NSHostingView(rootView: contentView)
    window.contentView = hostingView
    window.makeKeyAndOrderFront(nil)
    window.delegate = self
    NSApp.activate(ignoringOtherApps: true)
  }
}

public extension NSApplication
{
  var customMenu: NSMenu
  {
    let appMenu = NSMenuItem()
    appMenu.submenu = NSMenu()
    let appName = ProcessInfo.processInfo.processName
    appMenu.submenu?.addItem(NSMenuItem(title: "About \(appName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""))
    appMenu.submenu?.addItem(NSMenuItem.separator())
    let services = NSMenuItem(title: "Services", action: nil, keyEquivalent: "")
    self.servicesMenu = NSMenu()
    services.submenu = self.servicesMenu
    appMenu.submenu?.addItem(services)
    appMenu.submenu?.addItem(NSMenuItem.separator())
    appMenu.submenu?.addItem(NSMenuItem(title: "Hide \(appName)", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h"))
    let hideOthers = NSMenuItem(title: "Hide Others", action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h")
    hideOthers.keyEquivalentModifierMask = [.command, .option]
    appMenu.submenu?.addItem(hideOthers)
    appMenu.submenu?.addItem(NSMenuItem(title: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: ""))
    appMenu.submenu?.addItem(NSMenuItem.separator())
    appMenu.submenu?.addItem(NSMenuItem(title: "Quit \(appName)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    
    let windowMenu = NSMenuItem()
    windowMenu.submenu = NSMenu(title: "Window")
    windowMenu.submenu?.addItem(NSMenuItem(title: "Minmize", action: #selector(NSWindow.miniaturize(_:)), keyEquivalent: "m"))
    windowMenu.submenu?.addItem(NSMenuItem(title: "Zoom", action: #selector(NSWindow.performZoom(_:)), keyEquivalent: ""))
    windowMenu.submenu?.addItem(NSMenuItem.separator())
    windowMenu.submenu?.addItem(NSMenuItem(title: "Show All", action: #selector(NSApplication.arrangeInFront(_:)), keyEquivalent: "m"))
    
    let mainMenu = NSMenu(title: "Main Menu")
    mainMenu.addItem(appMenu)
    mainMenu.addItem(windowMenu)
    return mainMenu
  }
}


