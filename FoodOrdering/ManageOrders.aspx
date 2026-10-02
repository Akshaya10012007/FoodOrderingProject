<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageOrders.aspx.cs" Inherits="FoodOrdering.ManageOrders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Orders - Food Ordering System</title>
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
            <h2 class="page-title">Customer Orders</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message success"></asp:Label>

            <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                DataKeyNames="OrderId"
                OnRowDataBound="gvOrders_RowDataBound"
                OnRowCommand="gvOrders_RowCommand">
                <Columns>
                    <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" />
                    <asp:BoundField DataField="Address" HeaderText="Address" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:N2}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem>Pending</asp:ListItem>
                                <asp:ListItem>Preparing</asp:ListItem>
                                <asp:ListItem>Out for Delivery</asp:ListItem>
                                <asp:ListItem>Delivered</asp:ListItem>
                                <asp:ListItem>Cancelled</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnUpdateStatus" runat="server" Text="Update Status" CssClass="btn btn-green"
                                CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderId") %>' />
                            <asp:Button ID="btnViewItems" runat="server" Text="View Items" CssClass="btn"
                                CommandName="ViewItems" CommandArgument='<%# Eval("OrderId") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- Selected order-oda food items -->
            <asp:Panel ID="pnlItems" runat="server" Visible="false">
                <h3 style="margin-top:30px;">
                    <asp:Label ID="lblItemsTitle" runat="server"></asp:Label>
                </h3>
                <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="false" CssClass="data-table">
                    <Columns>
                        <asp:BoundField DataField="FoodId" HeaderText="Food ID" />
                        <asp:BoundField DataField="FoodName" HeaderText="Food Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:N2}" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>
