using System;
using System.Data;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        // Session-la irukkura cart-a screen-la kaattum
        private void LoadCart()
        {
            DataTable cart = Session["Cart"] as DataTable;

            if (cart == null || cart.Rows.Count == 0)
            {
                pnlCart.Visible = false;
                pnlEmpty.Visible = true;
                return;
            }

            pnlCart.Visible = true;
            pnlEmpty.Visible = false;

            rptCart.DataSource = cart;
            rptCart.DataBind();

            // Grand Total calculate
            decimal grandTotal = 0;
            foreach (DataRow row in cart.Rows)
            {
                grandTotal += (decimal)row["Price"] * (int)row["Quantity"];
            }
            lblGrandTotal.Text = "Grand Total: \u20B9 " + grandTotal.ToString("N2");
        }

        // Update Quantity and Remove button click
        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMessage.Text = "";
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null) return;

            int foodId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "UpdateQty")
            {
                TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
                int qty;

                if (!int.TryParse(txtQty.Text, out qty) || qty < 1)
                {
                    lblMessage.Text = "Quantity must be 1 or more";
                }
                else
                {
                    foreach (DataRow row in cart.Rows)
                    {
                        if ((int)row["FoodId"] == foodId)
                        {
                            row["Quantity"] = qty;
                            break;
                        }
                    }
                    Session["Cart"] = cart;
                }
            }
            else if (e.CommandName == "RemoveItem")
            {
                foreach (DataRow row in cart.Rows)
                {
                    if ((int)row["FoodId"] == foodId)
                    {
                        cart.Rows.Remove(row);
                        break;
                    }
                }
                Session["Cart"] = cart;
            }

            LoadCart();
        }

        // Place Order button click
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            // Login pannala-na Login page-ku anuppurom
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            Response.Redirect("Checkout.aspx");
        }
    }
}