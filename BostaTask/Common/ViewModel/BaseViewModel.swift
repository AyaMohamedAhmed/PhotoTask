//
//  BaseViewModel.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import RxSwift
import RxRelay

class BaseViewModel {
    let viewState:BehaviorRelay<UiState>
    var dispose:DisposeBag
    
    init(){
        self.viewState = BehaviorRelay(value: UiState.loading)
        self.dispose = DisposeBag()
    }
    
}

enum UiState {
    case loading
    case success
    case error
}
