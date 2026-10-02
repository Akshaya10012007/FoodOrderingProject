using System;


namespace FoodOrdering
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowCorrectPanel();
            }
        }

        private void ShowCorrectPanel()
        {
            bool isAdmin = Session["IsAdmin"] != null;
            pnlDashboard.Visible = isAdmin;
            pnlLogin.Visible = !isAdmin;
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (email == "admin@gmail.com" && password == "admin123")
            {
                Session["IsAdmin"] = "true";
                ShowCorrectPanel();
            }
            else
            {
                lblMessage.Text = "Invalid admin email or password.";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["IsAdmin"] = null;
            ShowCorrectPanel();
        }
    }
}