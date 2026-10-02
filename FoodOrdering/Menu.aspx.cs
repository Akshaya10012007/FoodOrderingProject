
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class Menu : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FoodDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFoods();
            }
        }

        // Database-la irundhu ellaa foods-um eduthu Repeater-la kaattum
        private void LoadFoods()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT FoodId, FoodName, Category, Description, Price, ImageUrl FROM Foods ORDER BY FoodId", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptFoods.DataSource = dt;
                rptFoods.DataBind();
            }
        }

        // Add to Cart button click
        protected void rptFoods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int foodId = Convert.ToInt32(e.CommandArgument);

                // Selected food details database-la irundhu edukkrom
                string foodName = "";
                decimal price = 0;
                string imageUrl = "";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT FoodName, Price, ImageUrl FROM Foods WHERE FoodId = @FoodId", con);
                    cmd.Parameters.AddWithValue("@FoodId", foodId);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        foodName = reader["FoodName"].ToString();
                        price = Convert.ToDecimal(reader["Price"]);
                        imageUrl = reader["ImageUrl"].ToString();
                    }
                    reader.Close();
                }

                // Cart Session-la irukka nu paakrom. Illa-na puthusa create pannrom
                DataTable cart = Session["Cart"] as DataTable;
                if (cart == null)
                {
                    cart = new DataTable();
                    cart.Columns.Add("FoodId", typeof(int));
                    cart.Columns.Add("FoodName", typeof(string));
                    cart.Columns.Add("Price", typeof(decimal));
                    cart.Columns.Add("Quantity", typeof(int));
                    cart.Columns.Add("ImageUrl", typeof(string));
                }

                // Already cart-la irundha quantity +1, illa-na puthu row
                bool found = false;
                foreach (DataRow row in cart.Rows)
                {
                    if ((int)row["FoodId"] == foodId)
                    {
                        row["Quantity"] = (int)row["Quantity"] + 1;
                        found = true;
                        break;
                    }
                }

                if (!found)
                {
                    cart.Rows.Add(foodId, foodName, price, 1, imageUrl);
                }

                Session["Cart"] = cart;
                lblMessage.Text = foodName + "added to cart!";
            }
        }
    }
}