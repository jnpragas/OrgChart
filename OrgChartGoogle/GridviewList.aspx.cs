using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace OrgChartGoogle
{
    public partial class GridviewList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            ds = (DataSet)Session["sessionds"];

            if (ds != null)
            {
                // Populates the dataset that was passed by the search button from OrgChart.aspx.
                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
            else
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

                string query = "SELECT id, nodeId, firstName, lastName, department, jobTitle, email, phone, image FROM Employees ORDER BY lastName, firstName, department";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataSet dsAll = new DataSet();
                da.Fill(dsAll);
                GridView1.DataSource = dsAll;
                GridView1.DataBind();
            }
        }

        /// <summary>
        /// Redirects to OrgChart.aspx and populates this employee and everyone below when the
        /// Select button is clicked.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var id = GridView1.SelectedDataKey.Value.ToString();
            Response.Redirect("OrgChart.aspx?id=" + Convert.ToInt32(id));
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }
    }
}