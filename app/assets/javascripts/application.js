// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require libs/jquery/jquery-migrate-1.2.1.min
// require libs/bootstrap/bootstrap
//= require bootstrap-sprockets
// Sorting and filter
//= require smart_listing
// Theme
//= require libs/spin.js/spin
//= require libs/autosize/jquery.autosize
//= require libs/nanoscroller/jquery.nanoscroller
//= require libs/DataTables/jquery.dataTables.min
//= require libs/DataTables/dataTables.buttons.min
//= require libs/DataTables/jszip.min
//= require libs/DataTables/pdfmake.min
//= require libs/DataTables/vfs_fonts
//= require libs/DataTables/buttons.html5.min
//= require libs/moment/moment
//= require libs/moment/moment.es
//= require libs/flot/jquery.flot.js
//= require_directory ./libs/flot/.
// require libs/select2/select2
//= require select2
//= require cocoon
//= require datatables
//= require extras
//= require_directory ./core/source/
//= require_directory .


// Obliga a la página a recargar en caso de congelarse los botones
$(document).on('click', '#home-path', function (e) {
    e.preventDefault();
    location.href = location.protocol + '//' + location.host;
});