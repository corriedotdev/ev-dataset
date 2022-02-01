using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Web;

namespace ChargeScotland {
    class Program {

        static void Main(string[] args) {
            Program p = new Program();

            string featurePath = @"C:\Users\Corrie Green\GitHub\ev-dataset\EV Charge Point Data\Data\feature-31-01-2022-21-25-00.json";
            string dynamicPath = @"C:\Users\Corrie Green\GitHub\ev-dataset\EV Charge Point Data\Data\dynamic-31-01-2022-21-25-00.json";

            // One time feature population
            // p.PopulateFeatureTables(featurePath);

            // One time dynamic population
            // p.PopulateDynamicTable(dynamicPath);

            // Many population
            // p.PopulateDynamicGroupTable(dynamicPath);

            //TODO 
            //      - Pass the file path inc filename where the json file will sit
            //      - get the date from the file name

        }



        public void PopulateDynamicGroupTable(string path) {

            // need to extract the time 
            var obj = JObject.Parse(File.ReadAllText(path));

            var time = GetTimeFromPath(path); //31-01-2022-20-38-50

            JArray items = (JArray)obj["chargePoints"];

            using (SqlConnection con = new SqlConnection(@"Data Source=CJG-LAPTOP\SQLEXPRESS;Initial Catalog=EV_DB;Integrated Security=True")) {

                for (int i = 0; i < items.Count; i++) {

                    var id = (int)obj["chargePoints"][i]["chargePoint"]["id"];
                    var name = (string)obj["chargePoints"][i]["chargePoint"]["name"];
                    var siteid = (int)obj["chargePoints"][i]["chargePoint"]["siteID"];

                    Console.WriteLine("DynamicGroup- Doing ID " + id + " ");

                    try {
                        using (var cmd = new SqlCommand("INSERT INTO DynamicConnectorGroups (ID, ConnectorID, Status, Time) VALUES (@ID,@ConnectorID,@Status,@Time)")) {

                            cmd.Connection = con;

                            var groupID = 0;
                            var status = "";

                            JArray connectorSize = (JArray)obj["chargePoints"][i]["chargePoint"]["connectorGroups"];
                            int size = connectorSize.Count;

                            for (int y = 0; y < size; y++) {

                                groupID = (int)connectorSize[y]["connectorGroupID"];

                                try {
                                    status = (string)connectorSize[y]["connectors"][0]["connectorStatus"].ToString();

                                } catch (Exception e) {

                                }

                                //if the connector group id is the same as the last one there is a data issue, pass it on
                                // id == 1001476
                                if (y > 0 && (int)connectorSize[y]["connectorGroupID"] ==
                                    (int)connectorSize[y - 1]["connectorGroupID"]) {
                                    // do nothing the data is shit in this entry
                                    Console.Write("DynamicGroup - Invalid group ID " + id);
                                } else {

                                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
                                    cmd.Parameters.Add("@ConnectorID", SqlDbType.Int).Value = groupID;
                                    cmd.Parameters.Add("@Status", SqlDbType.VarChar).Value = status;
                                    cmd.Parameters.Add("@Time", SqlDbType.DateTime).Value = time;

                                    con.Open();

                                    if (cmd.ExecuteNonQuery() > 0) {
                                        Console.WriteLine("DynamicGroup  - Done");
                                    } else {
                                        Console.WriteLine("DynamicGroup -  Table failed");
                                    }

                                    con.Close();
                                    cmd.Parameters.Clear();

                                }
                            }

                            Console.WriteLine("DynamicGroup - Done ID " + id);

                        }

                    } catch (Exception e) {
                        Console.WriteLine("Error during insert: " + e.Message);
                        con.Close();
                    }

                }

            }

            Console.WriteLine("DynamicGroup - Complete");

        }

        public void PopulateDynamicTable(string path) {

            // need to extract the time 
            var obj = JObject.Parse(File.ReadAllText(path));

            JArray items = (JArray)obj["chargePoints"];

            using (SqlConnection con = new SqlConnection(@"Data Source=CJG-LAPTOP\SQLEXPRESS;Initial Catalog=EV_DB;Integrated Security=True")) {

                for (int i = 0; i < items.Count; i++) {

                    var id = (int)obj["chargePoints"][i]["chargePoint"]["id"];
                    var name = (string)obj["chargePoints"][i]["chargePoint"]["name"];
                    var siteid = (int)obj["chargePoints"][i]["chargePoint"]["siteID"];

                    Console.WriteLine("Dynamic - Doing ID " + id + " ");

                    try {
                        using (var cmd = new SqlCommand("INSERT INTO Dynamic (ID, Name, SiteID) VALUES (@ID,@Name,@SiteID)")) {

                            cmd.Connection = con;

                            cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
                            cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = name;
                            cmd.Parameters.Add("@SiteID", SqlDbType.Int).Value = siteid;

                            con.Open();

                            if (cmd.ExecuteNonQuery() > 0) {
                                Console.WriteLine("Dynamic - Done");
                            } else {
                                Console.WriteLine("Dynamic -  Table failed");
                            }
                            con.Close();

                        }

                    } catch (Exception e) {
                        Console.WriteLine("Error during insert: " + e.Message);
                    }
                }

            }

            Console.WriteLine("Dynamic - Complete");

        }

        public void PopulateFeatureTables(string path) {

            // read JSON directly from a file
            var obj = JObject.Parse(File.ReadAllText(path));

            JArray items = (JArray)obj["features"];

            using (SqlConnection con = new SqlConnection(@"Data Source=CJG-LAPTOP\SQLEXPRESS;Initial Catalog=EV_DB;Integrated Security=True")) {

                for (int i = 0; i < items.Count; i++) {
                    var id = (int)obj["features"][i]["properties"]["id"];

                    // Populate the Feature table
                    var latitude = "";
                    var longitude = "";

                    for (int y = 0; y < 1; y++) {
                        latitude = (string)obj["features"][i]["geometry"]["coordinates"][y];
                        longitude = (string)obj["features"][i]["geometry"]["coordinates"][y + 1];
                    }

                    var name = (string)obj["features"][i]["properties"]["name"];
                    var siteid = (string)obj["features"][i]["properties"]["siteID"];

                    Console.WriteLine("Feature - Doing ID" + id + " " + name);

                    try {
                        using (var cmd = new SqlCommand("INSERT INTO Feature (ID, Name, SiteID, Longitude, Latitude) VALUES (@ID,@Name,@SiteID,@Longitude,@Latitude)")) {

                            cmd.Connection = con;

                            cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
                            cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = name;
                            cmd.Parameters.Add("@SiteID", SqlDbType.Int).Value = siteid;
                            cmd.Parameters.Add("@Longitude", SqlDbType.Decimal).Value = longitude;
                            cmd.Parameters.Add("@Latitude", SqlDbType.Decimal).Value = latitude;

                            con.Open();

                            if (cmd.ExecuteNonQuery() > 0) {
                                Console.WriteLine("Feature  - Done");
                            } else {
                                Console.WriteLine("Feature -  Table failed");
                            }
                            con.Close();

                        }

                    } catch (Exception e) {
                        Console.WriteLine("Error during insert: " + e.Message);
                    }


                    using (var cmd = new SqlCommand("INSERT INTO FeatureConnectorGroups " +
                               "(ID, ConnectorID, Plugtypename) VALUES (@ID,@ConnectorID,@PlugtypeName)")) {
                        cmd.Connection = con;

                        JArray connectorGroupSize = (JArray)obj["features"][i]["properties"]["connectorGroups"];
                        int size = connectorGroupSize.Count;

                        var connectorGroupId = "";
                        var connectorPlugType = "";

                        try {

                            for (int x = 0; x < size; x++) {
                                connectorGroupId = (string)connectorGroupSize[x]["connectorGroupID"]; // value was null so moved out of connectors array
                                connectorPlugType = (string)connectorGroupSize[x]["connectors"][0]["connectorPlugTypeName"];
                                // add to the db
                                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
                                cmd.Parameters.Add("@ConnectorID", SqlDbType.Int).Value = connectorGroupId;
                                cmd.Parameters.Add("@PlugtypeName", SqlDbType.VarChar).Value = connectorPlugType;

                                con.Open();


                                if (cmd.ExecuteNonQuery() > 0) {
                                    Console.WriteLine("Group - " + id + " added");
                                } else {
                                    Console.WriteLine("Group - " + id + " failed");
                                }

                                con.Close();
                                cmd.Parameters.Clear();
                            }

                            Console.WriteLine("Done");


                        } catch (Exception e) {
                            Console.WriteLine("Error during insert: " + e.Message);

                        }


                    }

                }

            }

            Console.WriteLine("Features & FeaturesGroups - Complete");


        }

        public DateTime GetTimeFromPath(string path) {

            string file = Path.GetFileNameWithoutExtension(path);
            string temp = file.Replace("feature-", "");
            temp = temp.Replace("dynamic-", "");

            string[] time = temp.Split('-'); // 31-01-2022-21-25-00
            DateTime t = new DateTime(Int32.Parse(time[2]), Int32.Parse(time[1]), Int32.Parse(time[0]),
                Int32.Parse(time[3]), Int32.Parse(time[4]), Int32.Parse(time[5]));

            return t;

        }


    }
}






