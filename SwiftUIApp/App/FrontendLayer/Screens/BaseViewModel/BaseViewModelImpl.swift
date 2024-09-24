//
//  BaseViewModelImpl.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 24/09/2024.
//

import SwiftUI
import Combine


typealias Cancellable = Set<AnyCancellable>

@MainActor
protocol BaseViewModel: ObservableObject {
    var isLoading: Bool { get }
    var alert: Alert? { get set }
    var router: ScreenFactory.Router { get }
    var cancellable: Cancellable { get set }

    func onFirstAppear()
    func onClose()
    func handleAPIError(error: Error, onClose:  (() -> ())?)
    func initBindings()
}

class BaseViewModelImpl: BaseViewModel {

    // MARK: Properties
    let router: ScreenFactory.Router

    var cancellable: Cancellable = []
    private(set) var didInitBindings = false

    @Published var isLoading = false
    @Published var alert: Alert?

    // MARK: Init
    init(
        router: ScreenFactory.Router
    ) {
        self.router = router

        initBindings()
    }

    // MARK: BaseViewModel
    func onFirstAppear() {
    }

    func onClose() {
    }

    func handleAPIError(error: Error, onClose: (() -> ())? = nil) {
//        log.error(
//            "BaseViewModelImpl.handleAPIError.error: \(error)"
//        )
//
//        let alertTitle = L10n.BaseViewModel.Alert.Error.title
//        let dismissButtonTitle = L10n.BaseViewModel.Alert.Error.dismissButtonTitle
//        var alertMessage = L10n.BaseViewModel.Alert.Error.loadingFailed
//
//        if let appError = error as? VCAppError {
//            alertMessage = appError.localizedMessage
//        }
//
//        onMainQueue { [weak self] in
//            let dismissButton = VCAlertBuilder.ButtonBuilder(
//                type: .normal,
//                text: dismissButtonTitle
//            ) {
//                onClose?()
//            }
//
//            self?.alert = .singleButton(
//                title: alertTitle,
//                message: alertMessage,
//                dismissButton: dismissButton
//            )
//        }
    }

    func initBindings() {
        didInitBindings = true
    }
}

// MARK: Private Methods
extension BaseViewModelImpl {
}
