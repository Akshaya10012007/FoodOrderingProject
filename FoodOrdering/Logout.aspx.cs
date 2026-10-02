using System;

namespace FoodOrdering
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Remove all session data (user, cart, admin)
            Session.Clear();
            Session.Abandon();

            // Go back to the login page
            Response.Redirect("Login.aspx");
        }
    }
}