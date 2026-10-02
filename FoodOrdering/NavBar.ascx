<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="FoodOrdering.NavBar" %>

<div class="navbar">
    <a class="logo" href="Default.aspx">Food Ordering System</a>
    <div class="menu">
        <a href="Default.aspx">Home</a>
        <a href="Menu.aspx">Menu</a>
        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="~/Cart.aspx" Text="Cart"></asp:HyperLink>
        <a href="MyOrders.aspx">My Orders</a>
        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/Login.aspx" Text="Login"></asp:HyperLink>
        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx" Text="Register"></asp:HyperLink>
        <asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/Logout.aspx" Text="Logout"></asp:HyperLink>
    </div>
</div>