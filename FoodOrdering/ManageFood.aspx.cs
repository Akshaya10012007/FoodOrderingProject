using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class ManageFood : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FoodDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdmin"] == null)
            {
                Response.Redirect("Admin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadFoods();
            }
        }

        // View: ellaa foods-um GridView-la kaattum
        private void LoadFoods()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT FoodId, FoodName, Category, Description, Price, ImageUrl FROM Foods ORDER BY FoodId", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvFoods.DataSource = dt;
                gvFoods.DataBind();
            }
        }

        // Edit button click
        protected void gvFoods_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFoods.EditIndex = e.NewEditIndex;
            LoadFoods();
        }

        // Cancel button click
        protected void gvFoods_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFoods.EditIndex = -1;
            LoadFoods();
        }

        // Update button click
        protected void gvFoods_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            lblMessage.CssClass = "message error";

            int foodId = Convert.ToInt32(gvFoods.DataKeys[e.RowIndex].Value);

            string name = Convert.ToString(e.NewValues["FoodName"]);
            string category = Convert.ToString(e.NewValues["Category"]);
            string description = Convert.ToString(e.NewValues["Description"]);
            string imageUrl = Convert.ToString(e.NewValues["ImageUrl"]);
            decimal price;

            if (!decimal.TryParse(Convert.ToString(e.NewValues["Price"]), out price) || price <= 0)
            {
                lblMessage.Text = "Please enter a valid price (e.g. 150).";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Foods SET FoodName=@FoodName, Category=@Category, Description=@Description, " +
                    "Price=@Price, ImageUrl=@ImageUrl WHERE FoodId=@FoodId", con);
                cmd.Parameters.AddWithValue("@FoodName", name);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);
                cmd.Parameters.AddWithValue("@FoodId", foodId);
                cmd.ExecuteNonQuery();
            }

            gvFoods.EditIndex = -1;
            LoadFoods();
            lblMessage.CssClass = "message success";
            lblMessage.Text = "Food updated successfully!";
        }

        // Delete button click
        protected void gvFoods_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int foodId = Convert.ToInt32(gvFoods.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Foods WHERE FoodId = @FoodId", con);
                cmd.Parameters.AddWithValue("@FoodId", foodId);
                cmd.ExecuteNonQuery();
            }

            LoadFoods();
            lblMessage.CssClass = "message success";
            lblMessage.Text = "Food deleted successfully!";
        }
    }
}