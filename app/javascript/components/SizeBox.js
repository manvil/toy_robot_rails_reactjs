import React from "react"
import PropTypes from "prop-types"
import TableTopFlux from './TableTopFlux'

class SizeBox extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      size: props.size
    }
    this.flux = TableTopFlux
    this.inputChange = this.inputChange.bind(this)
    this.publishSize = this.publishSize.bind(this)
  }

  inputChange(e) {
    this.setState({ size: e.target.value });
  }

  publishSize() {
    if (isNaN(this.state.size)) return
    var oldSize = this.flux.state.size;
    var currentY = this.flux.state.currentY
    if (!isNaN(oldSize) && !isNaN(currentY)) {
      currentY += this.state.size - oldSize
    }
    this.flux.actions.update({
      size: this.state.size,
      current_x: this.flux.state.currentX,
      current_y: currentY,
      direction: this.flux.state.direction,
      report: this.flux.state.report
    })
  }

  render () {
    return (
      <React.Fragment>
          Size:
          <input type="text" defaultValue={this.state.size} onChange={this.inputChange} placeholder="Enter the size of board"/>
          <button onClick={this.publishSize}>Modify Board</button>
      </React.Fragment>
    );
  }
}

SizeBox.propTypes = {
  size: PropTypes.number
};

export default SizeBox