<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddFood.aspx.cs" Inherits="FoodOrdering.AddFood" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Add Food - Food Ordering System</title>
    <link href="CSS/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">
            <a class="logo" href="Admin.aspx">Admin Panel</a>
            <div class="menu">
                <a href="Admin.aspx">Dashboard</a>
                <a href="AddFood.aspx">Add Food</a>
                <a href="ManageFood.aspx">Manage Food</a>
                <a href="ManageOrders.aspx">Manage Orders</a>
                <a href="Default.aspx">Home</a>
            </div>
        </div>

        <div class="container">
            <div class="form-box">
                <h2>Add Food</h2>

                <div class="form-group">
                    <label>Food Name</label>
                    <asp:TextBox ID="txtFoodName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Category</label>
                    <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Price</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Image Path (e.g. Images/pizza.jpg)</label>
                    <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <asp:Button ID="btnAdd" runat="server" Text="Add Food" CssClass="btn btn-green" OnClick="btnAdd_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            </div>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>