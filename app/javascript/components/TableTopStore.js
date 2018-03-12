import alt from './common/alt'
import TableTopActions from './TableTopActions'

class TableTopStore {
  constructor() {
    this.bindActions(TableTopActions)
  }

  onUpdate(response) {
    if(response.direction) this.direction = response.direction;
    if(!isNaN(response.current_x)) this.currentX = response.current_x;
    if(!isNaN(response.current_y)) this.currentY = response.current_y;
    this.report = response.report;
    if(!isNaN(response.size)) this.size = response.size;
  }
}

export default alt.createStore(TableTopStore, 'tableTopStore')
