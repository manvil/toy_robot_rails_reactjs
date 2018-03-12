import React from 'react';
import ReactDOM from 'react-dom';
import sinon from 'sinon';
import $ from 'jquery'

import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
configure({ adapter: new Adapter() });

import CommandBox from 'components/CommandBox';
import TableTop from 'components/TableTop';

test('command component', () => {
  var command = 'TEST COMMAND';
  const wrapper = shallow(<CommandBox command={command}/>);
  expect(wrapper.find('input')).toHaveLength(1);
  expect(wrapper.find('input').props().defaultValue).toEqual(command);
});

describe('command box and table top box', () => {
  var sandbox;
  beforeEach(function () {
      sandbox = sinon.sandbox.create();
  });

  afterEach(function () {
      sandbox.restore();
  });
  it('updates state', () => {
    var size = 5;
    var currentX = 1, currentY = 3, direction = 'north';
    
    const tableWrapper = mount(<TableTop size={size} currentX={currentX} currentY={currentY} direction={direction}/>);
    const commandWrapper = mount(<CommandBox />);

    commandWrapper.find('input').simulate('keypress', { target: { value: 'PLACE 1,1,NORTH' } })
    expect(commandWrapper.state().command).toEqual('PLACE 1,1,NORTH')
    commandWrapper.find('input').simulate('keypress', { key: 'Enter', keyCode: 13, which: 13 })
    expect(commandWrapper.state().command).toEqual(null)
  })

  it('fetch new position', () => {
    var size = 5;
    var currentX = 1, currentY = 3, direction = 'north';
    var returnData = {
      current_x: 1,
      current_y: 3,
      direction: 'EAST'
    }
    sandbox.stub($, 'ajax').callsFake((options) => {
      var d = $.Deferred();
      d.done(options.success(returnData));
      d.success = d.done;
      return d;
    })
    
    const tableWrapper = mount(<TableTop size={size} currentX={currentX} currentY={currentY} direction={direction}/>);
    const commandWrapper = mount(<CommandBox />);

    commandWrapper.find('input').simulate('keypress', { key: 'Enter', keyCode: 13, which: 13 })
    expect(tableWrapper.state()).toEqual(
      { currentX: 1,
        currentY: 3,
        direction: 'EAST',
        size: 5,
        report: undefined }
    );
  })

  it('should report', () => {
    var size = 5;
    var currentX = 1, currentY = 3, direction = 'north';
    var returnData = {
      current_x: 3,
      current_y: 0,
      direction: 'WEST',
      report: '1,1,WEST'
    }
    sandbox.spy(TableTop.prototype, 'render');
    sandbox.stub($, 'ajax').callsFake((options) => {
      var d = $.Deferred();
      d.done(options.success(returnData));
      d.success = d.done;
      return d;
    })
    
    const tableWrapper = mount(<TableTop size={size} currentX={currentX} currentY={currentY} direction={direction}/>);
    const commandWrapper = mount(<CommandBox />);

    commandWrapper.find('input').simulate('keypress', { key: 'Enter', keyCode: 13, which: 13 })
    expect(tableWrapper.state()).toEqual(
      { currentX: 3,
        currentY: 0,
        direction: 'WEST',
        size: 5,
        report: '1,1,WEST' }
    );
  })
});