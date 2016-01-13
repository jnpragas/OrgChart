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
    public partial class Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                successLabel.Text = "";
        }

        /// <summary>
        /// Creates user when this button is clicked.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CreateButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OrgChartGoogleContext"].ConnectionString);

            string queryCheckIfExist = "SELECT count(*) from Employees WHERE nodeId = @nodeId";
            string queryInsert = "INSERT INTO Employees(nodeId, parentId, firstName, lastName, departmentId, department, jobTitle, email, phone, image)" +
                                 "VALUES(@nodeId, @parentId, @firstName, @lastName, @departmentId, @department, @jobTitle, @email, @phone, @image)";

            SqlCommand cmdCheckIfExist = new SqlCommand(queryCheckIfExist, con);
            SqlCommand cmdInsert = new SqlCommand(queryInsert, con);

            cmdCheckIfExist.Parameters.AddWithValue("@nodeId", nodeIdTextBox.Text);
            con.Open();
            int count = (int)cmdCheckIfExist.ExecuteScalar();

            if (count > 0)
            {
                // Validates if employee ID already exists.
                CustomValidator1.IsValid = false;    
            }
            else
            {
                CustomValidator1.IsValid = true;
                cmdInsert.Parameters.AddWithValue("@nodeId", nodeIdTextBox.Text);
                cmdInsert.Parameters.AddWithValue("@firstName", firstNameTextBox.Text);
                cmdInsert.Parameters.AddWithValue("@lastName", lastNameTextBox.Text);
                cmdInsert.Parameters.AddWithValue("@jobTitle", jobTitleTextBox.Text);
                cmdInsert.Parameters.AddWithValue("@email", emailTextBox.Text);
                cmdInsert.Parameters.AddWithValue("@phone", phoneTextBox.Text);
                cmdInsert.Parameters.AddWithValue("@image", pictureTextBox.Text);

                if (ComboBox1.SelectedIndex.Equals(0))
                {

                    cmdInsert.Parameters.AddWithValue("@parentId", "");
                }
                else
                {
                    cmdInsert.Parameters.AddWithValue("@parentId", ComboBox1.SelectedItem.Value);
                }

                if (ComboBox2.SelectedIndex.Equals(0))
                {
                    cmdInsert.Parameters.AddWithValue("@departmentId", DBNull.Value);
                    cmdInsert.Parameters.AddWithValue("@department", DBNull.Value);
                }
                else
                {
                    cmdInsert.Parameters.AddWithValue("@departmentId", ComboBox2.SelectedItem.Value);
                    cmdInsert.Parameters.AddWithValue("@department", ComboBox2.SelectedItem.Text);
                }
                cmdInsert.ExecuteNonQuery();
                successLabel.Text = "Successfully created employee.";    
            }
            con.Close();
        }
    }
}