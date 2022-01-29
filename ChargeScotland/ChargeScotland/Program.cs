using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;


namespace ChargeScotland {
    class Program {

        static void Main(string[] args) {


            //JObject o1 = JObject.Parse(File.ReadAllText(@"C:\Users\Corrie Green\Google Drive\Corrie Green\corriedotdev\EV Charge Point Data\feature_280122.json"));

            // read JSON directly from a file
            var obj = JObject.Parse(File.ReadAllText(@"C:\Users\Corrie Green\Google Drive\Corrie Green\corriedotdev\EV Charge Point Data\feature_280122.json"));

            JArray items = (JArray)obj["features"];


            for (int i = 0; i < items.Count; i++) {
                var latitude = "";
                var longitude = "";
                //each object
                for (int y=0; y < 1; y++) {
                    latitude = (string)obj["features"][i]["geometry"]["coordinates"][y];
                    longitude = (string)obj["features"][i]["geometry"]["coordinates"][y + 1];
                }

                var name = (string)obj["features"][i]["properties"]["name"];
                var id = (string)obj["features"][i]["properties"]["id"];
                var siteid = (string)obj["features"][i]["properties"]["siteID"];

                //loop
                JArray connectorGroupSize = (JArray)obj["features"][i]["properties"]["connectorGroups"];
                int size = connectorGroupSize.Count;

                var connectorGroupId = "";
                var connectorPlugType = "";

                for (int x = 0; x < size; x++) {
                    connectorGroupId = (string)connectorGroupSize[x]["connectors"][0]["connectorID"];
                    connectorPlugType = (string)connectorGroupSize[x]["connectors"][0]["connectorPlugTypeName"];
                }

                Console.WriteLine("ADDED: " + latitude.ToString() + "\n" +
                                  longitude.ToString() + "\n" +
                                  name.ToString() + "\n" +
                                  id.ToString() + "\n" +
                                  siteid.ToString() + "\n" +
                                  connectorGroupId.ToString() + "\n" +
                                  connectorPlugType.ToString() + "\n");

            }
        }
    }
}





