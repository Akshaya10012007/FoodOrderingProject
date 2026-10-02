using System;
using System.Data;

namespace FoodOrdering
{
    public partial class NavBar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Show Login/Register only when the user is not logged in
            bool isLoggedIn = Session["UserId"] != null;
            lnkLogin.Visible = !isLoggedIn;
            lnkRegister.Visible = !isLoggedIn;
            lnkLogout.Visible = isLoggedIn;

            // Show the number of items in the cart
            int count = 0;
            DataTable cart = Session["Cart"] as DataTable;
            if (cart != null)
            {
                foreach (DataRow row in cart.Rows)
                {
                    count += (int)row["Quantity"];
                }
            }
            lnkCart.Text = count > 0 ? "Cart (" + count + ")" : "Cart";
        }
    }
}