<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridviewList.aspx.cs" Inherits="OrgChartGoogle.GridviewList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <link href="GoogleOrgChart.css" rel="stylesheet" />
    <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript' src='js/jquery.min.js'></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="navigation">
            <asp:ImageButton ID="BackButton" runat="server" Style="position: absolute; left: 20px; top: 26%;" ImageUrl="~/images/01_arrow_left-128.png" Width="40px" OnClientClick="JavaScript:window.history.back(1); return false;" />
            <asp:ImageButton ID="LogoButton" runat="server" Style="position: relative;" ImageUrl="~/images/csulogo.png" Width="290px" PostBackUrl="~/OrgChart.aspx" />
            <asp:ImageButton ID="AddPersonButton" runat="server" Style="position: absolute; float: right; top: 20%; right: 20px;" ImageUrl="~/images/add.png" Width="45px" Height="45px" PostBackUrl="~/Create.aspx" />
        </div>
        <div style="padding-top: 8%;"">

            <asp:GridView ID="GridView1" style="margin-left:auto; margin-right:auto;" runat="server" AllowPaging="True" AutoGenerateColumns="False"  CellPadding="4" ForeColor="#333333" GridLines="None" Width="80%" DataKeyNames="id" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" PageSize="50" ShowHeaderWhenEmpty="True" EmptyDataText="No records Found" OnPageIndexChanging="GridView1_PageIndexChanging">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CommandField>
                    <asp:ImageField DataImageUrlField="image">
                        <ControlStyle Height="50px" Width="50px" />
                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                    </asp:ImageField>
                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" InsertVisible="False" ReadOnly="True" Visible="False" >
                    </asp:BoundField>
                    <asp:BoundField DataField="nodeId" HeaderText="Employee ID" SortExpression="nodeId" Visible="False" >
                    </asp:BoundField>
                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" >
                    </asp:BoundField>
                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" >
                    </asp:BoundField>
                    <asp:BoundField DataField="department" HeaderText="Department" SortExpression="department" >
                    </asp:BoundField>
                    <asp:BoundField DataField="jobTitle" HeaderText="Job Title" SortExpression="jobTitle" >
                    </asp:BoundField>
                    <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                    <asp:BoundField DataField="phone" HeaderText="Phone" SortExpression="phone" />
                    <asp:BoundField DataField="image" HeaderText="Image" SortExpression="image" Visible="False" />
                </Columns>
                <EmptyDataRowStyle BackColor="#FFFBD6" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" HorizontalAlign="Center" />
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OrgChartGoogleContext %>" SelectCommand="SELECT [id], [nodeId], [firstName], [lastName], [department], [jobTitle], [email], [phone], [image] FROM [Employees] ORDER BY [lastName], [firstName], [department]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
