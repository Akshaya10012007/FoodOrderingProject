using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace FoodOrdering
{
    public partial class MyOrders : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FoodDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Login pannala-na Login page-ku anuppurom
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        // Logged-in user-oda orders mattum database-la irundhu edukkrom
        private void LoadOrders()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT OrderId, OrderDate, TotalAmount, Status FROM Orders WHERE UserId = @UserId ORDER BY OrderDate DESC", con);
                da.SelectCommand.Parameters.AddWithValue("@UserId", userId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlOrders.Visible = false;
                    pnlEmpty.Visible = true;
                }
                else
                {
                    pnlOrders.Visible = true;
                    pnlEmpty.Visible = false;
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                }
            }
        }
    }
}