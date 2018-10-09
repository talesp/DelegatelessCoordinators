//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

open class Coordinator: NSObject, CoordinatorProtocol {

    public var parent: CoordinatorProtocol?

    public var childCoordinators: [String : CoordinatorProtocol] = [:]

    public typealias CoordinatorProtocolType = Coordinator

    private(set) public var handlers: [String: (AppEvent) -> Void] = [:]

    public weak var rootViewController: UIViewController?

    public init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }

    open func start(with completion: @escaping () -> Void = {}) {
        self.rootViewController?.parentCoordinator = self
        completion()
    }

    open func stop(with completion: @escaping () -> Void = {}) {
        self.rootViewController?.parentCoordinator = nil
        completion()
    }

    open func startChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void = {}) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parent = self
        coordinator.start(with: completion)
    }

    public func stopChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void = {}) {
        coordinator.parent = nil
        coordinator.stop { [unowned self] in
            self.childCoordinators.removeValue(forKey: coordinator.identifier)
            completion()
        }
    }
    public func add<T>(event: T.Type, handler: @escaping (T) -> Void) where T : AppEvent {
        handlers[String(reflecting: event)] = { ev in
            guard let realEV = ev as? T else { return }
            handler(realEV)
        }
    }
    
    public func handle<T: AppEvent>(event: T) {
        let target = self.target(forEvent: event)
        guard let handler = target?.handlers[String(reflecting: type(of: event))] else {
            fatalError("Add a handler for event [\(String(reflecting:event))]")
        }
        handler(event)
    }

    public final func canHandle<T: AppEvent>(event: T) -> Bool {
        return handlers[String(reflecting: type(of: event))] != nil
    }

    public func target<T: AppEvent>(forEvent event: T) -> CoordinatorProtocol? {
        guard self.canHandle(event: event) != true else { return self }
        var next = self.parent
        while next?.canHandle(event: event) != true {
            next = next?.parent
        }
        guard next != nil else { fatalError("Add a handler for event [\(String(reflecting:event))]") }
        return next
    }


}
