using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace OrgChartGoogle
{
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var id = Request.QueryString["id"];

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

                string query = "SELECT parentId, firstName, lastName, departmentId, department, jobTitle, email, phone, image FROM Employees WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader reader;
                con.Open();
                reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    firstNameTextBox.Text = reader["firstName"].ToString();
                    lastNameTextBox.Text = reader["lastName"].ToString();
                    jobTitleTextBox.Text = reader["jobTitle"].ToString();
                    emailTextBox.Text = reader["email"].ToString();
                    phoneTextBox.Text = reader["phone"].ToString();
                    pictureTextBox.Text = reader["image"].ToString();
                    ComboBox2.SelectedItem.Value = reader["departmentId"].ToString();
                    ComboBox2.SelectedItem.Text = reader["department"].ToString();
                    if (reader["image"].ToString() != "")
                    {
                        employeeImage.ImageUrl = reader["image"].ToString();
                    }
                    else
                    {
                        employeeImage.ImageUrl = "../images/profile.png";
                    }
                    string parentId = reader["parentId"].ToString();

                    string query2 = "SELECT firstName, lastName, nodeId FROM Employees WHERE nodeId = @nodeId";
                    SqlCommand cmd2 = new SqlCommand(query2, con);

                    cmd2.Parameters.AddWithValue("@nodeId", parentId);

                    SqlDataReader reader2;
                    reader2 = cmd2.ExecuteReader();

                    if (reader2.Read())
                    {
                        ComboBox1.SelectedItem.Value = reader2["nodeId"].ToString();
                        ComboBox1.SelectedItem.Text = reader2["firstName"].ToString() + " " + reader2["lastName"].ToString(); ;
                    }
                }
                con.Close();}
        }
        
        /// <summary>
        /// Updates employee information when this button is clicked.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            var id = Request.QueryString["id"];

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

            string query = "UPDATE Employees SET parentId = @parentId, firstName = @firstName, lastName = @lastName, departmentId = @departmentId, department = @department, jobTitle = @jobTitle, email = @email, phone = @phone, image = @image WHERE id = @id ";
            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@parentId", ComboBox1.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@firstName", firstNameTextBox.Text);
            cmd.Parameters.AddWithValue("@lastName", lastNameTextBox.Text);
            cmd.Parameters.AddWithValue("@departmentId", ComboBox2.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@department", ComboBox2.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@jobTitle", jobTitleTextBox.Text);
            cmd.Parameters.AddWithValue("@email", emailTextBox.Text);
            cmd.Parameters.AddWithValue("@phone", phoneTextBox.Text);
            cmd.Parameters.AddWithValue("@image", pictureTextBox.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            successLabel.Text = "Successfully updated employee";          
        }

        /// <summary>
        /// Deletes and employee when this button is clicked.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            var id = Request.QueryString["id"];

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

            string query = "DELETE FROM Employees WHERE id = @id";
            SqlCommand cmdDelete = new SqlCommand(query, con);

            cmdDelete.Parameters.AddWithValue("@id", id);

            con.Open();
            cmdDelete.ExecuteNonQuery();
            con.Close();

            Response.Redirect("~/OrgChart.aspx");
        }
    }
}