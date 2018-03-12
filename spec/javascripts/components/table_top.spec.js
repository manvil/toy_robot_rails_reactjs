import React from 'react';
import ReactDOM from 'react-dom';
import sinon from 'sinon';

import { render, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
configure({ adapter: new Adapter() });

import TableTop from 'components/TableTop';
import SizeBox from 'components/SizeBox';
import TableTopStore from 'components/TableTop';

test('table top component without coordinates', () => {
  var size=5;
  const wrapper = render(<TableTop size={size}/>);
  expect(wrapper.find('.unit-box').length).toEqual(25);
});

test('table top component with coordinates', () => {
  var size = 5;
  var currentX = 1, currentY = 3, direction = 'north';
  const wrapper = render(<TableTop size={size} currentX={currentX} currentY={currentY} direction={direction}/>);
  expect(wrapper.find('.unit-box').length).toEqual(size * size);
  expect(wrapper.find('.robot').hasClass("column-" + currentX)).toEqual(true);
  expect(wrapper.find('.robot').hasClass(direction)).toEqual(true);
  expect(wrapper.find('.robot').parent().hasClass("row-" + currentY)).toEqual(true);
});


describe('size box and table top box', () => {
  it('updates size', () => {
    var size = 5;
    var currentX = 1, currentY = 3, direction = 'north';
    sinon.spy(TableTop.prototype, 'generateTable');
    const tableWrapper = mount(<TableTop size={size} currentX={currentX} currentY={currentY} direction={direction}/>);
    const sizeWrapper = mount(<SizeBox size={size}/>);

    sizeWrapper.find('input').simulate('change', { target: { value: 6 } })
    sizeWrapper.find('button').simulate('click');
    expect(TableTop.prototype.generateTable.callCount).toEqual(2);
    expect(tableWrapper.state().size).toEqual(6)
  })
});