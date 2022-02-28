import React from 'react';
import { SvgIcon, SvgIconProps } from '@material-ui/core';
import { ReactComponent as JokerIcon } from './images/joker.svg';

export default function Keys(props: SvgIconProps) {
  return <SvgIcon component={JokerIcon} viewBox="0 0 150 58" {...props} />;
}
