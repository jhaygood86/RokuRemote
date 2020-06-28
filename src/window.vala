/* window.vala
 *
 * Copyright 2020 Justin Haygood
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Rokuremote {
	[GtkTemplate (ui = "/com/reaktix/RokuRemote/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
		Gtk.ComboBox device_list;

		[GtkChild]
	    Gtk.Button back_button;

	    [GtkChild]
	    Gtk.Button preferences_button;

	    [GtkChild]
	    Gtk.Button home_button;

	    [GtkChild]
	    Gtk.Button up_button;

	    [GtkChild]
	    Gtk.Button ok_button;

	    [GtkChild]
	    Gtk.Button left_button;

	    [GtkChild]
	    Gtk.Button right_button;

	    [GtkChild]
	    Gtk.Button down_button;

	    [GtkChild]
	    Gtk.Button rwd_button;

	    [GtkChild]
	    Gtk.Button play_button;

	    [GtkChild]
	    Gtk.Button ffwd_button;

		private RokuManager roku_manager;

		public Window (Gtk.Application app) {
			Object (application: app);

            configure_style();

		    roku_manager = new RokuManager();
		    roku_manager.find_devices();

		    configure_roku_selector();

            back_button.clicked.connect(on_back_clicked);
            preferences_button.clicked.connect(on_preferences_clicked);
		    home_button.clicked.connect(on_home_clicked);
		    up_button.clicked.connect(on_up_clicked);
		    ok_button.clicked.connect(on_ok_clicked);
		    left_button.clicked.connect(on_left_clicked);
		    right_button.clicked.connect(on_right_clicked);
		    down_button.clicked.connect(on_down_clicked);
		    rwd_button.clicked.connect(on_rewind_clicked);
		    play_button.clicked.connect(on_play_clicked);
		    ffwd_button.clicked.connect(on_fastforward_clicked);

		    Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;
		}

		private void configure_style(){

            Gtk.CssProvider css_provider = new Gtk.CssProvider();
            css_provider.load_from_resource("/com/reaktix/RokuRemote/window.css");

            var screen = Gdk.Screen.get_default();
            Gtk.StyleContext.add_provider_for_screen(screen,css_provider,Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
		}

		private void configure_roku_selector(){
		    device_list.set_model(roku_manager.roku_devices);

		    var renderer = new Gtk.CellRendererText();
		    device_list.pack_start(renderer,true);
		    device_list.add_attribute(renderer,"text",0);

		    device_list.set_id_column(1);

		    device_list.active = 0;

		    device_list.changed.connect(device_list_changed);
		}

		private void device_list_changed(Gtk.ComboBox device_list){
		    activate_buttons();
		}

		private void activate_buttons(){
            back_button.sensitive = true;
            home_button.sensitive = true;
            preferences_button.sensitive = true;
            up_button.sensitive = true;
            ok_button.sensitive = true;
            left_button.sensitive = true;
            right_button.sensitive = true;
            down_button.sensitive = true;
            rwd_button.sensitive = true;
            play_button.sensitive = true;
            ffwd_button.sensitive = true;
		}

		private void press_roku_key(string key){
		   var roku_device = roku_manager.get_device(device_list.active_id);
		   roku_device.press_key(key);
		}

		private void on_back_clicked(Gtk.Button back_button){
		    press_roku_key("back");
		}

		private void on_home_clicked(Gtk.Button home_button){
		    press_roku_key("home");
		}

		private void on_preferences_clicked(Gtk.Button preferences_button){
		    press_roku_key("info");
		}

		private void on_up_clicked(Gtk.Button up_button){
		    press_roku_key("up");
		}

		private void on_ok_clicked(Gtk.Button ok_button){
		    press_roku_key("select");
		}

		private void on_left_clicked(Gtk.Button left_button){
		    press_roku_key("left");
		}

		private void on_right_clicked(Gtk.Button right_button){
		    press_roku_key("right");
		}

		private void on_down_clicked(Gtk.Button down_button){
		    press_roku_key("down");
		}

		private void on_rewind_clicked(Gtk.Button rewind_button){
		    press_roku_key("rev");
		}

		private void on_play_clicked(Gtk.Button play_button){
		    press_roku_key("play");
		}

		private void on_fastforward_clicked(Gtk.Button forward_button){
		    press_roku_key("fwd");
		}
	}
}
