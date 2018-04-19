resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_scripts {
	"client/animations.lua",
	"client/main.lua"
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server/mysqltimestamp.lua",
	"server/main.lua"
}

ui_page 'client/html/dist/index.html'

files {
	'client/html/dist/index.html',
	'client/html/dist/static/css/app.css',
	'client/html/dist/static/js/app.js',
	'client/html/dist/static/js/manifest.js',
	'client/html/dist/static/js/vendor.js',

	'client/html/dist/static/img/call.png',
	'client/html/dist/static/img/contacts.png',
	'client/html/dist/static/img/sms.png',
	'client/html/dist/static/img/settings.png',

	'client/html/dist/static/img/back001.jpg',
	'client/html/dist/static/img/back002.jpg',
	'client/html/dist/static/img/back003.jpg',
	'client/html/dist/static/img/01.jpg',
	'client/html/dist/static/img/02.jpg',
	'client/html/dist/static/img/03.jpg',
	'client/html/dist/static/img/04.jpg',
	'client/html/dist/static/img/05.jpg',
	'client/html/dist/static/img/06.jpg',
	'client/html/dist/static/img/07.jpg',
	'client/html/dist/static/img/08.jpg',
	'client/html/dist/static/img/09.jpg',
	'client/html/dist/static/img/10.jpg',
	'client/html/dist/static/img/11.jpg',
	'client/html/dist/static/img/12.jpg',
	'client/html/dist/static/img/13.jpg',
	'client/html/dist/static/img/14.jpg',
	'client/html/dist/static/img/15.jpg',
	'client/html/dist/static/img/16.jpg',
	'client/html/dist/static/img/17.jpg',
	'client/html/dist/static/img/18.jpg',
	'client/html/dist/static/img/19.jpg',
	'client/html/dist/static/img/20.jpg',
	'client/html/dist/static/img/21.jpg',

	'client/html/dist/static/img/apple.png',
	'client/html/dist/static/img/galaxy-s8.png',
	'client/html/dist/static/img/samsung.png',
	'client/html/dist/static/img/windows-phone.png',

	'client/html/dist/static/fonts/fontawesome-webfont.woff2',
}

dependencies {
	'mysql-async'
}
