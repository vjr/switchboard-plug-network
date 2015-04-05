// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2015 Adam Bieńkowski (http://launchpad.net/switchboard-network-plug)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Corentin Noël <tintou@mailoo.org>
 */

namespace Network.Widgets {
    public class WiFiPage : Gtk.ScrolledWindow {
        private Gtk.ListBox wifi_list;

        public WiFiPage (NM.Client client) {
            wifi_list = new Gtk.ListBox ();
            wifi_list.selection_mode = Gtk.SelectionMode.SINGLE;
            wifi_list.activate_on_single_click = false; 

            var control_row = new Gtk.ListBoxRow ();
            control_row.selectable = false;
            var control_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            var control_label = new Gtk.Label ("Wi-Fi");
            control_label.get_style_context ().add_class ("h2");

            var control_switch = new Gtk.Switch ();
            control_switch.active = client.wireless_get_enabled ();

            control_switch.notify["active"].connect (() => {
                client.wireless_set_enabled (control_switch.get_active ());
            });

            control_box.pack_start (control_label, false, false, 0);
            control_box.pack_end (control_switch, false, false, 0);
            control_row.add (control_box);

            wifi_list.add (control_row);
            this.add (wifi_list);
            this.show_all ();   
        }

        public void list_connections_from_device (NM.DeviceWifi wifidevice) {
            var access_points = wifidevice.get_access_points ();
            access_points.@foreach ((access_point) => {
                print (access_point.get_bssid () + "\n");
                print (NM.Utils.ssid_to_utf8 (access_point.get_ssid ()));

                uint strength = access_point.get_strength ();
                
                var row = new Gtk.ListBoxRow ();
                var hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
                row.add (hbox);
            });       
        }             
    }  
}