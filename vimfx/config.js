console.log("Loading vimvx config file")

let {commands} = vimfx.modes.normal;

// Config options

let options = {
  "blacklist": "",
  "config_file_directory": "~/.config/vimfx",
  "mode.normal.copy_current_url": "y",
  "mode.normal.history_back": "b",
  "mode.normal.history_forward": "<c-r>",
  "mode.normal.stop": "<c-c>",
  "mode.normal.scroll_half_page_down": "",
  "mode.normal.scroll_half_page_up": "",
  "mode.normal.tab_select_previous": "<s-tab> ",
  "mode.normal.tab_select_next": "<tab> ",
  "mode.normal.tab_move_backward": "<",
  "mode.normal.tab_move_forward": ">",
  "mode.normal.tab_close": "d",
  "mode.normal.tab_restore": "u",
  "mode.normal.enter_mode_ignore": "i <Insert>",
  "mode.ignore.exit": "<Insert>",
}

Object.entries(options).forEach(([option, value]) => vimfx.set(option, value))

// Vimperator-like quickmarks

let quickmarks = {
	"a": "https://www.amazon.co.uk/",
	"f": "https://www.facebook.com/",
	"g": "https://gmail.com",
	"p": "http://thepiratebay.org/",
	"r": "http://www.reddit.com/",
	"y": "http://www.youtube.com/",
	"z": "https://forum.zwame.pt/",
}

function addQuickmark(shortcut, url) {

	vimfx.addCommand({
	  name: 'open_' + shortcut,
	  description: 'open ' + url,
	}, ({vim}) => {
	  vim.window.gBrowser.selectedTab = vim.window.gBrowser.loadURI(url)
	})

	vimfx.addCommand({
	  name: 'tabopen_' + shortcut,
	  description: 'tabopen ' + url,
	}, ({vim}) => {
	  vim.window.gBrowser.selectedTab = vim.window.gBrowser.addTab(url)
	})

	vimfx.set('custom.mode.normal.open_' + shortcut, 'go' + shortcut)
	vimfx.set('custom.mode.normal.tabopen_' + shortcut, 'gn' + shortcut)
}

Object.entries(quickmarks).forEach(([shortcut, url]) => addQuickmark(shortcut, url))

// Search selection

vimfx.addCommand({
	name: 'search_selected_text',
	description: 'Search for the selected text',
}, ({vim}) => {
	let {messageManager} = vim.window.gBrowser.selectedBrowser
	vimfx.send(vim, 'getSelection', null, selection => {
		let inTab = true // Change to `false` if you’d like to search in current tab.
		vim.window.BrowserSearch.loadSearch(selection, inTab)
	})
})
vimfx.set('custom.mode.normal.search_selected_text', 's');

// Focus URL with the cursor at the end
vimfx.addCommand({
    name: 'focus_unhighlighted_location_bar',
    description: 'Focus the location bar with the URL unhighlighted',
    category: 'location',
    order: commands.focus_location_bar.order + 1,
}, (args) => {
    commands.focus_location_bar.run(args);
    let active = args.vim.window.document.activeElement;
    active.selectionStart = active.selectionEnd;
});
vimfx.set('custom.mode.normal.focus_unhighlighted_location_bar', 'O');


vimfx.addCommand({
    name: 'edit_search_wikipedia',
    description: 'Focus the location bar the search prepared',
    category: 'location',
    order: commands.focus_location_bar.order + 1,
}, (args) => {
    args.vim.window.gURLBar.value = 'w '
    commands.focus_location_bar.run(args);
    let active = args.vim.window.document.activeElement;
    active.selectionStart = active.selectionEnd;
});
vimfx.set('custom.mode.normal.edit_search_wikipedia', ',w');
