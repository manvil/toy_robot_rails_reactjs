import React from 'react';
import ReactDOM from 'react-dom';

import { shallow, mount, configure } from 'enzyme';
import sinon from 'sinon';
import Adapter from 'enzyme-adapter-react-16';
configure({ adapter: new Adapter() });

import SizeBox from 'components/SizeBox';

test('size box component', () => {
  var size=5;
  const wrapper = shallow(<SizeBox size={size}/>);
  expect(wrapper.find('input')).toHaveLength(1);
  expect(wrapper.find('button')).toHaveLength(1);
  expect(wrapper.find('input').props().defaultValue).toEqual(size);
});

describe('size box change', () => {
  it('size box simulate size update', () => {
    sinon.spy(SizeBox.prototype, 'publishSize');
    sinon.spy(SizeBox.prototype, 'inputChange');
    var size=5;
    const wrapper = mount(<SizeBox size={size}/>);
    wrapper.find('input').text(6);
    wrapper.find('button').simulate('click');
  })
});
