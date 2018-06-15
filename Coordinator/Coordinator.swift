//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {

    var parent: CoordinatorProtocol? { get set }

    var identifier: String { get }

    func canHandle(event: AppEvent, withSender sender: Any?) -> Bool
    func target(forEvent event: AppEvent, withSender sender: Any?) -> CoordinatorProtocol?
    func handle(event: AppEvent, withSender sender: Any?)

    func start(with completion: @escaping () -> Void)
    func stop(with completion: @escaping () -> Void)

    var childCoordinators: [String: CoordinatorProtocol] { get }

    func startChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void)
    func stopChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void)
}

extension CoordinatorProtocol {
    var identifier: String {
        return String(describing: type(of: self))
    }
}

class Coordinator: NSObject, CoordinatorProtocol {
    private struct AssociatedKeys {
        static var RootViewController = "RootViewController"
        static var ChildCoordinators = "ChildCoordinators"
        static var ParentCoordinator = "ParentCoordinator"
    }

    weak var rootViewController: UIViewController?

    weak var parent: CoordinatorProtocol?

    var childCoordinators: [String: CoordinatorProtocol] = [:]

    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }

    func start(with completion: @escaping () -> Void = {}) {
        self.rootViewController?.parentCoordinator = self
        completion()
    }

    func stop(with completion: @escaping () -> Void = {}) {
        self.rootViewController?.parentCoordinator = nil
        completion()
    }

    func startChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void = {}) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parent = self
        coordinator.start(with: completion)
    }

    func stopChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void = {}) {
        coordinator.parent = nil
        coordinator.stop { [unowned self] in
            self.childCoordinators.removeValue(forKey: coordinator.identifier)
            completion()
        }
    }

    func canHandle(event: AppEvent, withSender sender: Any?) -> Bool {
        return false
    }

    func target(forEvent event: AppEvent, withSender sender: Any?) -> CoordinatorProtocol? {
        guard self.canHandle(event: event, withSender: sender) != true else { return self }
        var next = self.parent
        while next?.canHandle(event: event, withSender: sender) != true {
            next = next?.parent
        }
        return next
    }

    func handle(event: AppEvent, withSender sender: Any?) {
        let target = self.target(forEvent: event, withSender: sender)
        target?.handle(event: event, withSender: self)
    }

}
