using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class ManageOrders : System.Web.UI.Page
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
                LoadOrders();
            }
        }

        // Ellaa customers-oda orders-um kaattum
        private void LoadOrders()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT OrderId, CustomerName, Phone, Address, OrderDate, TotalAmount, Status FROM Orders ORDER BY OrderDate DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        // Ovvoru row-layum dropdown-la current status select pannum
        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlStatus");
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

                ListItem item = ddl.Items.FindByValue(status);
                if (item != null)
                {
                    ddl.SelectedValue = status;
                }
            }
        }

        // Update Status and View Items button click
        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                DropDownList ddl = (DropDownList)row.FindControl("ddlStatus");

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE Orders SET Status = @Status WHERE OrderId = @OrderId", con);
                    cmd.Parameters.AddWithValue("@Status", ddl.SelectedValue);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.ExecuteNonQuery();
                }

                LoadOrders();
               
                lblMessage.Text = "Order #" + orderId + " status updated to '" + ddl.SelectedValue + "'.";
            }
            else if (e.CommandName == "ViewItems")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter(
                        "SELECT FoodId, FoodName, Quantity, Price, Total FROM OrderDetails WHERE OrderId = @OrderId", con);
                    da.SelectCommand.Parameters.AddWithValue("@OrderId", orderId);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvItems.DataSource = dt;
                    gvItems.DataBind();
                }

                lblItemsTitle.Text = "Order #" + orderId + " - Ordered Items";
                pnlItems.Visible = true;
            }
        }
    }
}