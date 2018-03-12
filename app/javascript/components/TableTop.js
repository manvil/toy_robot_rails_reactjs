import React from "react"
import PropTypes from "prop-types"
import TableTopFlux from './TableTopFlux'
import _ from 'lodash'

class UnitBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      coordinateX: props.coordinateX
    }
  }

  render() {
    var klass = `unit-box column-${this.state.coordinateX}`;
    if(this.props.direction) {
      klass += ` robot ${this.props.direction}`
    }
    return (
      <React.Fragment>
        <div className={klass}>
        </div>
      </React.Fragment>
    );
  }
}

class TableTop extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentX: props.currentX,
      currentY: props.currentY,
      direction: props.direction,
      size: props.size,
      report: props.report
    };
    this.flux = TableTopFlux
    this.flux.actions.update({
      currentX: this.state.currentY, currentY: this.state.currentY,
      direction: this.state.direction, size: this.state.size,
      report: this.state.report
    })
    this.changeSelected = this.changeSelected.bind(this)
    this.validNumber = this.validNumber.bind(this)
    this.generateTable = this.generateTable.bind(this)
  }

  componentDidMount() {
    this.flux.listen(this.changeSelected.bind(this));
  }

  componentWillUnmount() {
    this.flux.unlisten(this.changeSelected.bind(this))
  }

  changeSelected() {
    var newState = this.flux.state
    if (!_.isEmpty(newState)) {
      this.setState({
        currentX: newState.currentX, currentY: newState.currentY,
        direction: newState.direction, report: newState.report,
        size: newState.size || this.state.size
      })
    }
  }
  
  validNumber(n) {
    return !isNaN(n) && (n >2 && n < 10)
  }

  generateTable() {
    const sizeNow = this.state.size;
    var rows = [];
    for (var rowindex = 0; rowindex < sizeNow; rowindex++) {
      var units = [];
      for (var colindex = 0; colindex < sizeNow; colindex++) {
        var hasRobot = (this.state.currentX == colindex && this.state.currentY == rowindex)
        var direct = hasRobot ? this.state.direction : null
        var unitBox = (
          <UnitBox key={`column-${colindex}`} coordinateX={colindex} coordinateY={rowindex} direction={direct}>
          </UnitBox>
        );
        units.push(unitBox);
      }
      rows.push(<div key={`row-${rowindex}`} className={`row row-${rowindex}`}>{units}</div>);
    }
    return (<div className="table-top">{rows}</div>);
  }

  render () {
    return (
      <React.Fragment>
        Use the command box below to navigate the robot
        {this.generateTable()}
        <div className="bottom-fixed entire-width">
          <input className="entire-width" type="text" disabled value={this.state.report || ""} />
        </div>
      </React.Fragment>
    );
  }
}

TableTop.propTypes = {
  size: PropTypes.number,
  currentX: PropTypes.number,
  currentY: PropTypes.number,
  direction: PropTypes.string,
  report: PropTypes.string
}

UnitBox.propTypes = {
  coordinateX: PropTypes.number,
  coordinateY: PropTypes.number,
  direction: PropTypes.string
}
export default TableTop
