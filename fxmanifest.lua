fx_version 'adamant'
game 'gta5'

author 'MARFY'
version '1.0.1'

ui_page 'ui/index.html'

client_script 'cl_chat.lua'

server_scripts {
  'sv_chat.lua',
  'cmd.lua',
}

files {
  'ui/index.html',
  'ui/css/style.css',
  'ui/js/config.default.js',
  'ui/js/App.js',
  'ui/js/Message.js',
  'ui/js/Suggestions.js',
  'ui/vendor/vue.2.3.3.min.js',
  'ui/vendor/flexboxgrid.6.3.1.min.css',
  'ui/vendor/animate.3.5.2.min.css',
}

lua54 'yes'
