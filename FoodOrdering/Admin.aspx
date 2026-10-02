<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="FoodOrdering.Admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin - Food Ordering System</title>
    <link href="CSS/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">
            <a class="logo" href="Default.aspx">Food Ordering System</a>
            <div class="menu">
                <a href="Default.aspx">Home</a>
                <a href="Menu.aspx">Menu</a>
                <a href="Cart.aspx">Cart</a>
                <a href="MyOrders.aspx">My Orders</a>
                <a href="Login.aspx">Login</a>
                <a href="Register.aspx">Register</a>
            </div>
        </div>

        <div class="container">

            <!-- Admin Login -->
            <asp:Panel ID="pnlLogin" runat="server">
                <div class="form-box">
                    <h2>Admin Login</h2>
                    <div class="form-group">
                        <label>Admin Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnAdminLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnAdminLogin_Click" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="message error"></asp:Label>
                </div>
            </asp:Panel>

            <!-- Admin Dashboard -->
            <asp:Panel ID="pnlDashboard" runat="server" Visible="false">
                <h2 class="page-title">Admin Dashboard</h2>
                <div class="food-grid">
                    <div class="admin-box">
                        <h3>Add Food</h3>
                        <a href="AddFood.aspx" class="btn">Open</a>
                    </div>
                    <div class="admin-box">
                        <h3>Manage Food</h3>
                        <p>View / Update / Delete</p>
                        <a href="ManageFood.aspx" class="btn">Open</a>
                    </div>
                    <div class="admin-box">
                        <h3>Manage Orders</h3>
                        <p>View orders / Update status</p>
                        <a href="ManageOrders.aspx" class="btn">Open</a>
                    </div>
                </div>
                <p style="text-align:center; margin-top:25px;">
                    <asp:Button ID="btnLogout" runat="server" Text="Admin Logout" CssClass="btn btn-red" OnClick="btnLogout_Click" />
                </p>
            </asp:Panel>

        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>