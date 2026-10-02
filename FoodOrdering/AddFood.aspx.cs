using System;
using System.Configuration;
using System.Data.SqlClient;

namespace FoodOrdering
{
    public partial class AddFood : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FoodDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin login pannala-na Admin page-ku anuppurom
            if (Session["IsAdmin"] == null)
            {
                Response.Redirect("Admin.aspx");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMessage.CssClass = "message error";

            string name = txtFoodName.Text.Trim();
            string category = txtCategory.Text.Trim();
            string description = txtDescription.Text.Trim();
            string imageUrl = txtImageUrl.Text.Trim();
            decimal price;

            if (name == "" || category == "")
            {
                lblMessage.Text = "Food Name and Category are required.";
       
                return;
            }

            if (!decimal.TryParse(txtPrice.Text.Trim(), out price) || price <= 0)
            {
                lblMessage.Text = "Please enter a valid price (e.g. 150).";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Foods (FoodName, Category, Description, Price, ImageUrl) " +
                    "VALUES (@FoodName, @Category, @Description, @Price, @ImageUrl)", con);
                cmd.Parameters.AddWithValue("@FoodName", name);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);
                cmd.ExecuteNonQuery();
            }

            lblMessage.CssClass = "message success";
            lblMessage.Text = name + "added successfully!";

            txtFoodName.Text = "";
            txtCategory.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtImageUrl.Text = "";
        }
    }
}