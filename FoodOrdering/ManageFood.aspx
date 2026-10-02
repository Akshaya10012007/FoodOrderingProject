<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageFood.aspx.cs" Inherits="FoodOrdering.ManageFood" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Food - Food Ordering System</title>
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
            <h2 class="page-title">Manage Food</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <asp:GridView ID="gvFoods" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                DataKeyNames="FoodId"
                OnRowEditing="gvFoods_RowEditing"
                OnRowCancelingEdit="gvFoods_RowCancelingEdit"
                OnRowUpdating="gvFoods_RowUpdating"
                OnRowDeleting="gvFoods_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="FoodId" HeaderText="ID" ReadOnly="true" />
                    <asp:BoundField DataField="FoodName" HeaderText="Food Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="ImageUrl" HeaderText="Image Path" />
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true"
                        EditText="Edit" UpdateText="Update" CancelText="Cancel" DeleteText="Delete" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>