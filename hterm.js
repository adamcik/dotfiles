// Run in the JavaScript console of the hterm browser window

const data = Object.fromEntries(`
background #212121
foreground #eeffff
color0 #2b2b2b
color8 #404040
color1 #f07178
color9 #ff8b92
color2 #c3e88d
color10 #ddffa7
color3 #ffcb6b
color11 #ffe585
color4 #82aaff
color12 #9cc4ff
color5 #c792ea
color13 #e1acff
color6 #89ddff
color14 #a3f7ff
color15 #ffffff
selection_foreground #212121
selection_background #eeffff
cursor_text_color background
`.split(/\n+/).map(l => l.split(/ +/)));

const hexToRGB = (hex, alpha=1.0) => {
  const r = parseInt(hex.slice(1, 3), 16),
        g = parseInt(hex.slice(3, 5), 16),
        b = parseInt(hex.slice(5, 7), 16);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

term_.setProfile('material-dark');

term_.prefs_.set('background-color', data.background);
term_.prefs_.set('foreground-color', data.foreground);

term_.prefs_.set('color-palette-overrides', [
	data.color0,   // black
	data.color1,   // red
	data.color2,   // green
	data.color3,   // yellow
	data.color4,   // blue
	data.color5,   // magenta
	data.color6,   // cyan
	data.color7,   // white
	data.color8,   // brblack
	data.color9,   // brred
	data.color10,  // brgreen
	data.color11,  // bryellow
	data.color12,  // brblue
	data.color13,  // brmagenta
	data.color14,  // brcyan
	data.color15   // brwhite
]);

term_.prefs_.set('cursor-shape', 'BEAM');
term_.prefs_.set('cursor-color', hexToRGB(data.selection_background, 0.1));

term_.prefs_.set('user-css', 'https://fonts.googleapis.com/css2?family=Fira+Code');
term_.prefs_.set('font-size', 12);
term_.prefs_.set('font-smoothing', 'subpixel-antialiased');
term_.prefs_.set('font-family', "'Fira Code', monospace;");
