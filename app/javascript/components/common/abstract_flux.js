class AbstractFlux {
    constructor(actions, store) {
        this.fluxActions = actions
        this.fluxStore = store
    }

    get actions() {
        return this.fluxActions
    }

    get state() {
        return this.fluxStore.getState()
    }

    listen(f) {
        this.fluxStore.listen(f)
    }

    unlisten(f) {
        this.fluxStore.unlisten(f)
    }
}

export default AbstractFlux
