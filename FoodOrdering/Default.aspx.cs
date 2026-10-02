using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // User login pannirundha welcome message kaattum
            if (Session["UserName"] != null)
            {
                lblWelcome.Text = "Welcome, " + Session["UserName"].ToString() + "!";
            }
            else
            {
                lblWelcome.Text = "";
            }
        }
    }
}