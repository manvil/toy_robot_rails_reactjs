import React from 'react'
import PropTypes from 'prop-types'
import TableTopFlux from './TableTopFlux'
import CommandBoxLoader from './CommandBoxLoader'

class CommandBox extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      command: props.command
    }
    this.tableFlux = TableTopFlux
    this.commabdBoxLoader = new CommandBoxLoader()
    this.handleKeyPress = this.handleKeyPress.bind(this)
  }

  handleKeyPress(e) {
    if (e.key == 'Enter') {
      this.commabdBoxLoader.fetch({ command: {
        size: this.tableFlux.state.size,
        current_x: this.tableFlux.state.currentX,
        current_y: this.tableFlux.state.currentY,
        direction: this.tableFlux.state.direction,
        command: e.target.value
      }})
      this.setState({ command: null })
      e.target.value = null
    } else {
      this.setState({ command: e.target.value });
    }
  }

  render () {
    return (
      <React.Fragment>
        Type in your commands<br />
        <input className="entire-width" type="text" defaultValue={this.state.command} onKeyPress={this.handleKeyPress}
               placeholder="Enter your command"/>
      </React.Fragment>
    );
  }
}

CommandBox.propTypes = {
  command: PropTypes.string
}

export default CommandBox
