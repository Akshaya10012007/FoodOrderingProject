using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace FoodOrdering
{
    public partial class Checkout : System.Web.UI.Page
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

            // Cart empty-na Cart page-ku anuppurom (order success aana pinnadi illa)
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                if (!pnlSuccess.Visible && !IsPostBack)
                {
                    Response.Redirect("Cart.aspx");
                    return;
                }
            }

            if (!IsPostBack)
            {
                LoadUserDetails();
                LoadItems();
                lblOrderDate.Text = DateTime.Now.ToString("dd-MMM-yyyy hh:mm tt");
            }
        }

        // Logged-in user-oda name and phone-a database-la irundhu edukkrom
        private void LoadUserDetails()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Name, Phone FROM Users WHERE UserId = @UserId", con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtName.Text = reader["Name"].ToString();
                    txtPhone.Text = reader["Phone"].ToString();
                }
                reader.Close();
            }
        }

        // Cart items-a table-la kaattum, total calculate pannum
        private void LoadItems()
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null) return;

            rptItems.DataSource = cart;
            rptItems.DataBind();

            lblTotal.Text = "Total Amount: \u20B9 " + GetCartTotal(cart).ToString("N2");
        }

        private decimal GetCartTotal(DataTable cart)
        {
            decimal total = 0;
            foreach (DataRow row in cart.Rows)
            {
                total += (decimal)row["Price"] * (int)row["Quantity"];
            }
            return total;
        }

        // Place Order button click
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();

            if (name == "" || phone == "" || address == "")
            {
                lblMessage.Text = "Please fill in Name, Phone and Address.";
                return;
            }

            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                lblMessage.Text = "Your cart is empty.";
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            decimal totalAmount = GetCartTotal(cart);
            int orderId;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    // 1. Orders table-la order save
                    SqlCommand orderCmd = new SqlCommand(
                        "INSERT INTO Orders (UserId, CustomerName, Phone, Address, OrderDate, TotalAmount, Status) " +
                        "VALUES (@UserId, @CustomerName, @Phone, @Address, @OrderDate, @TotalAmount, 'Pending'); " +
                        "SELECT CAST(SCOPE_IDENTITY() AS INT);", con, tran);

                    orderCmd.Parameters.AddWithValue("@UserId", userId);
                    orderCmd.Parameters.AddWithValue("@CustomerName", name);
                    orderCmd.Parameters.AddWithValue("@Phone", phone);
                    orderCmd.Parameters.AddWithValue("@Address", address);
                    orderCmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                    orderCmd.Parameters.AddWithValue("@TotalAmount", totalAmount);

                    orderId = (int)orderCmd.ExecuteScalar();

                    // 2. Ovvoru food-ayum OrderDetails table-la save
                    foreach (DataRow row in cart.Rows)
                    {
                        int qty = (int)row["Quantity"];
                        decimal price = (decimal)row["Price"];

                        SqlCommand detailCmd = new SqlCommand(
                            "INSERT INTO OrderDetails (OrderId, FoodId, FoodName, Quantity, Price, Total) " +
                            "VALUES (@OrderId, @FoodId, @FoodName, @Quantity, @Price, @Total)", con, tran);

                        detailCmd.Parameters.AddWithValue("@OrderId", orderId);
                        detailCmd.Parameters.AddWithValue("@FoodId", (int)row["FoodId"]);
                        detailCmd.Parameters.AddWithValue("@FoodName", row["FoodName"].ToString());
                        detailCmd.Parameters.AddWithValue("@Quantity", qty);
                        detailCmd.Parameters.AddWithValue("@Price", price);
                        detailCmd.Parameters.AddWithValue("@Total", price * qty);
                        detailCmd.ExecuteNonQuery();
                    }

                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    lblMessage.Text = "Order could not be saved:  " + ex.Message;
                    return;
                }
            }

            // 3. Cart clear panni success message kaattum
            Session["Cart"] = null;
            pnlCheckout.Visible = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text = "Your order was placed successfully! Order ID: " + orderId + " | Total: \u20B9 " + totalAmount.ToString("N2");
        }
    }
}