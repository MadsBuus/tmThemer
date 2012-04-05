# encoding: utf-8
require_relative 'tmTheme'

PALETTE = {
  darkness: '#232323',
  shadow: '#323B42',
  dark_blue: '#046380',  blue: '#378C8C',  blue2: '#88BECF',  blue_green: '#54868A',
  green: '#78BBC2',
  yellow: '#E9DE6A',
  white: '#FEFEFE',
  dark_gray: '#5F6B65',  gray: '#9DB1A7', light_gray: '#D1DFD6', lighter_gray: '#E1EFE6',
  pale: '#ECEDC3',
  light_brown: '#C7AB7D',  brown: '#7F6D50',  dark_brown: '#635640'
}

theme = TmTheme.new('Test', 'Mads Buus Westmark',
  background: PALETTE[:darkness],
  caret: PALETTE[:light_gray],
  foreground: PALETTE[:light_gray],
  invisibles: '#FFFFFF40',
  lineHighlight: '#FFFFFF08',
  selection: PALETTE[:shadow]
)

theme['Comment'] = { foreground: PALETTE[:dark_gray], fontStyle: 'italic'}
theme['Constant'] = { foreground: PALETTE[:blue2] }
theme['Keyword'] = { foreground: PALETTE[:pale] }
theme['Entity'] = { foreground: PALETTE[:white] }
theme['Storage'] = { foreground: PALETTE[:yellow] }
theme['String'] = { foreground: PALETTE[:light_brown] }
theme['Support'] = { foreground: PALETTE[:blue] }
theme['Variable'] = { foreground: PALETTE[:gray] }
theme['♦ String embedded-source'] = { foreground: PALETTE[:yellow] }

puts theme.to_plist