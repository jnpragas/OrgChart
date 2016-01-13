using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Services;
using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.IO;
using System.Text;

namespace OrgChartGoogle
{
    public partial class OrgChart : System.Web.UI.Page
    {
        // Calls javascript function in OrgChart.aspx which populates the OrgChart 
        // when the page loads.
        protected void Page_Load(object sender, EventArgs e)
        {

            Session["sessionds"] = null;
            var id = Request.QueryString["id"];
            if (id != null)
            {
                // Populates OrgChart when user selects an employee from the GridViewList.aspx page.
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyFunction", " getDown('" + id + "');", true);
            }
            else
            {
                // Populates OrgChart starting with David Meier, id = 3776.
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyFunction", " getDown(3776);", true);
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyFunction", "drawChart();", true); 
            }
        }

        /// <summary>
        /// Search for employee and outputs to GridView.aspx containing
        /// queried list of employees.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void searchBtn_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

            string query = "SELECT * FROM Employees WHERE firstName LIKE '%" + searchTextBox.Text + "%'" +
                                                      "OR lastName LIKE '%" + searchTextBox.Text + "%'" +
                                                      "OR department LIKE '%" + searchTextBox.Text + "%'" +
                                                      "OR jobTitle LIKE '%" + searchTextBox.Text + "%'";

            // Creates a dataset so it is passed to the GridViewList.aspx page.
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            Session["sessionds"] = ds;
            Response.Redirect("GridviewList.aspx");
        }

        /// <summary>
        /// Populates the OrgChart by department automatically when the
        /// user selects a department from the list.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DepartmentDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //GetChartData();   // Calling below function to convert dt to json

            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyFunction", "getDepartment();", true);
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public List<object> GetChartData()
        {
            string query = "SELECT * FROM Employees WHERE department = @department";
            //query += " FROM EmployeesHierarchy";
            string constr = ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);

            SqlCommand cmd = new SqlCommand(query);

            cmd.Parameters.AddWithValue("@department", DepartmentDropDownList.SelectedItem.Text);
            List<object> chartData = new List<object>();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                chartData.Add(new object[]
                {
                    sdr["id"], sdr["nodeId"], sdr["parentId"], sdr["firstName"], sdr["lastName"], sdr["departmentId"], sdr["department"], sdr["jobTitle"], sdr["email"], sdr["phone"], sdr["image"]
                });
            }

            con.Close();
            return chartData;


        }

        //public string ConvertDataTabletoString()
        //{
        //    DataTable dt = new DataTable();
        //    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

        //    string query = "SELECT * FROM Employees WHERE department = @department";
        //    SqlCommand cmd = new SqlCommand(query, con);
        //    cmd.Parameters.AddWithValue("@department", DepartmentDropDownList.SelectedItem.Text);

        //    con.Open();
        //    cmd.ExecuteNonQuery();
        //    con.Close();

        //    SqlDataAdapter da = new SqlDataAdapter(cmd);
        //    da.Fill(dt);
        //    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        //    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        //    Dictionary<string, object> row;
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        row = new Dictionary<string, object>();
        //        foreach (DataColumn col in dt.Columns)
        //        {
        //            row.Add(col.ColumnName, dr[col]);
        //        }
        //        rows.Add(row);
        //    }
        //    return serializer.Serialize(rows);
        //}
    }
}