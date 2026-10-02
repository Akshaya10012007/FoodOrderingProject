using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMessage.CssClass = "message error";

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;
            string confirm = txtConfirmPassword.Text;

            // 1. Ellaa fields-um fill pannirukkangala nu check
            if (name == "" || email == "" || phone == "" || password == "")
            {
                lblMessage.Text = " fill it.";
                return;
            }

            // 2. Password match check
            if (password != confirm)
            {
                lblMessage.Text = "Password and Confirm Password doesnt match.";
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["FoodDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 3. Email already irukka nu check
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", con);
                checkCmd.Parameters.AddWithValue("@Email", email);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    lblMessage.Text = " email already registered.";
                    return;
                }

                // 4. Puthu user insert
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Users (Name, Email, Phone, Password) VALUES (@Name, @Email, @Phone, @Password)", con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.ExecuteNonQuery();
            }

            lblMessage.CssClass = "message success";
            lblMessage.Text = "Registration success! Now Login.";

            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
        }
    }
}