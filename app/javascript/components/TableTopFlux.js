import TableTopActions from './TableTopActions'
import TableTopStore from './TableTopStore'
import AbstractFlux from './common/abstract_flux'

class TableTopFlux extends AbstractFlux {
    constructor(actions, store) {
        super(actions, store)
    }
}

export default new TableTopFlux(TableTopActions, TableTopStore)
