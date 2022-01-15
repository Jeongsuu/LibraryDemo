//
//  FruitReactor.swift
//  ReactorKitExample
//
//  Created by Ian on 2022/01/15.
//

import Foundation
import ReactorKit

class FruitReactor: Reactor {

    // MARK: - Actions
    enum Action {
        case apple
        case banana
        case grape
    }

    // MARK: - States
    struct State {
        var fruitName: String
        var isLoading: Bool
    }

    // MARK: - Mutations
    enum Mutation {
        case changeLabelApple
        case changeLabelBanana
        case changeLabelGrape
        case setLoading(Bool)
    }

    let initialState: State

    init() {
        self.initialState = .init(fruitName: "선택되어진 값 없음", isLoading: false)
    }

    // MARK: - Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .apple:
            return Observable.concat([
                .just(Mutation.setLoading(true)),
                .just(Mutation.changeLabelApple).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                .just(Mutation.setLoading(false))
            ])
        case .banana:
            return Observable.concat([
                .just(Mutation.setLoading(true)),
                .just(Mutation.changeLabelBanana).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                .just(Mutation.setLoading(false))
            ])
        case .grape:
            return Observable.concat([
                .just(Mutation.setLoading(true)),
                .just(Mutation.changeLabelGrape).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                .just(Mutation.setLoading(false))
            ])
        }
    }

    // MARK: - Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case .changeLabelApple:
            state.fruitName = "사과"
        case .changeLabelBanana:
            state.fruitName = "바나나"
        case .changeLabelGrape:
            state.fruitName = "포도"
        case .setLoading(let bool):
            state.isLoading = bool
        }

        return state
    }
}
