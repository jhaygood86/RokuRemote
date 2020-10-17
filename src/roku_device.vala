using Soup;
using GXml;

namespace Rokuremote {
    public class RokuDevice {

        private string _usn;
        private string _location;
        private string _name;
        private string _application_name;

        public RokuDevice(string usn,GLib.List<string> locations){
            _usn = usn;
            _location = locations.nth_data(0);

            load_device_info();
        }

        public string usn {
            get { return _usn; }
        }

        public string location {
            get { return _location; }
        }

        public string name {
            get { return _name; }
        }

        public string application_name {
            get { return _application_name; }
        }

        private void load_device_info(){
            var device_info_url = "%squery/device-info".printf(_location);

            var session = new Soup.Session();
            var message = new Soup.Message("GET",device_info_url);

            session.send_message(message);

            var memory_input_stream = new MemoryInputStream.from_data(message.response_body.data);

            var document = new Document.from_stream(memory_input_stream);
            var device_name_node = document.query_selector("user-device-name");

            _name = device_name_node.text_content;
        }

        public void press_key(string button){
            var keypress_url = "%skeypress/%s".printf(_location,button);

            var session = new Soup.Session();
            var message = new Soup.Message("POST",keypress_url);

            session.queue_message(message, null);
        }

        public void load_current_application(){
            var app_info_url = "%squery/active-app".printf(_location);

            var session = new Soup.Session();
            var message = new Soup.Message("GET",app_info_url);

            session.queue_message(message,current_application_callback);
        }

        private void current_application_callback(Soup.Session session, Soup.Message message){
            var memory_input_stream = new MemoryInputStream.from_data(message.response_body.data);

            var document = new Document.from_stream(memory_input_stream);
            var app_node = document.query_selector("app");

            _application_name = app_node.text_content;
        }
    }
}
