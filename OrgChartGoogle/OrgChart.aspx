<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgChart.aspx.cs" Inherits="OrgChartGoogle.OrgChart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <link href="GoogleOrgChart.css" rel="stylesheet" />
    <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript' src='js/jquery.min.js'></script>
    <script type="text/javascript">

        // Load the Visualization API and the package.
        google.load('visualization', '1', { 'packages': ['orgchart'] });

        // Set a callback to run when the Google Visualization API is loaded.

        //google.setOnLoadCallback(drawChart);

        function drawChart() {
            $.ajax({
                url: "http://localhost:5603/api/Employees/GetEmployees",
                type: "GET",
                dataType: "json",
                success: function (result) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'nodeId');
                    data.addColumn('string', 'ParentEntity');
                    data.addColumn('string', 'id');
                    data.addColumn('string', 'ToolTip');
                    for (var i = 0; i < result.length; i++) {
                        if (result[i].parentId.toString() == null) {
                            var parentId = "";
                        }
                        else if (result[i].parentId.toString() != null) {
                            var parentId = result[i].parentId.toString();
                        }
                        var id = result[i].id;
                        var nodeId = result[i].nodeId.toString();
                        //var parentId = result[i].parentId.toString() != null ? result[i].parentId.toString() : '';
                        var firstName = result[i].firstName;
                        var lastName = result[i].lastName;
                        var department = result[i].department;
                        var jobTitle = result[i].jobTitle;
                        var email = result[i].email;
                        var phone = result[i].phone;
                        var image = result[i].image;
                        var toolTip = "Click for details.";
                        data.addRows([[{
                            v: nodeId,
                            f: '<div style="width:270px;">' +
                                    '<div>' +
                                        '<img src="' + image + '" style="width:75px; height:75px; float:left;"</img>' +
                                    '</div>' +
                                    '<div style="padding-left:90px;">' +
                                        '<div class="name">' + firstName + " " + lastName + '</div>' +
                                        '<div style="color:white; text-align:left;">' + jobTitle + '</div>' +
                                        '<div style="color:white; text-align:left;">' + department + '</div>' +
                                    '</div>' +
                                    '<div>' +
                                    '</br>' +
                                        '<div style="float:left;"><a href="javascript:void(0)" onClick="getUp(' + id + ')"><img src="../images/ArrowUp.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:left;" ><a href="javascript:void(0)" onClick="getDown(' + id + ')"><img src="../images/ArrowDown.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:right;"><a href="javascript:void(0)" onClick="getDetails(' + id + ')"><img src="../images/button.png" style="width:80px;" </img></a></div>' +
                                    '</div>' +
                               '</div>'
                        }, parentId, toolTip, id.toString()]]);
                    }
                    var chart = new google.visualization.OrgChart($("#chart")[0]);
                    chart.draw(data, { allowHtml: true, color: "#e44243", selectionColor: "#7D9AB8", allowCollapse: true, size: "medium" });


                    google.visualization.events.addListener(chart, 'select', function () {
                        var selection = chart.getSelection();
                        var message = '';
                        for (var i = 0; i < selection.length; i++) {
                            var item = selection[i];
                            var str = data.getFormattedValue(item.row, 2);
                            message += '{row:' + item.row + ', column:none}; value (col 3) id = ' + str + '\n';
                            //alert('You selected ' + message);
                        }
                    });
                },
                failure: function () {
                    alert("Failure");
                },
                error: function () {
                    alert("Error");
                }
            });
        }

        function getDetails(id) {
            window.location.href = "Details.aspx?id=" + id;
        }

        function getDepartment() {
            $.ajax({
                type: "POST",
                url: "OrgChart.aspx/GetChartData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'nodeId');
                    data.addColumn('string', 'ParentEntity');
                    data.addColumn('string', 'id');
                    data.addColumn('string', 'ToolTip');
                    for (var i = 0; i < result.length; i++) {
                        if (i == 0) {
                            var parentId = "";
                        }
                        else {
                            var parentId = result[i].parentId.toString();
                        }
                        var id = result[i].id;
                        var nodeId = result[i].nodeId.toString();
                        //var parentId = result[i].parentId.toString() != null ? result[i].parentId.toString() : '';
                        var firstName = result[i].firstName;
                        var lastName = result[i].lastName;
                        var department = result[i].department;
                        var jobTitle = result[i].jobTitle;
                        var email = result[i].email;
                        var phone = result[i].phone;
                        var image = result[i].image;
                        var toolTip = "Click for details.";
                        data.addRows([[{
                            v: nodeId,
                            f: '<div style="width:270px;">' +
                                    '<div>' +
                                        '<img src="' + image + '" style="width:75px; height:75px; float:left;"</img>' +
                                    '</div>' +
                                    '<div style="padding-left:90px;">' +
                                        '<div class="name">' + firstName + " " + lastName + '</div>' +
                                        '<div style="color:white; text-align:left;">' + jobTitle + '</div>' +
                                        '<div style="color:white; text-align:left;">' + department + '</div>' +
                                    '</div>' +
                                    '<div>' +
                                    '</br>' +
                                        '<div style="float:left;"><a href="javascript:void(0)" onClick="getUp(' + id + ')"><img src="../images/ArrowUp.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:left;" ><a href="javascript:void(0)" onClick="getDown(' + id + ')"><img src="../images/ArrowDown.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:right;"><a href="javascript:void(0)" onClick="getDetails(' + id + ')"><img src="../images/button.png" style="width:80px;" </img></a></div>' +
                                    '</div>' +
                               '</div>'
                        }, parentId, toolTip, id.toString()]]);
                    }
                    var chart = new google.visualization.OrgChart($("#chart")[0]);
                    chart.draw(data, { allowHtml: true, color: "#E22E2F", selectionColor: "#7D9AB8", allowCollapse: true, size: "medium" });
                    google.visualization.events.addListener(chart, 'select', function () {
                        var selection = chart.getSelection();
                        var message = '';
                        for (var i = 0; i < selection.length; i++) {
                            var item = selection[i];
                            var str = data.getFormattedValue(item.row, 3);
                            message += '{row:' + item.row + ', column:none}; value (col 3) id = ' + str + '\n';
                            //alert('You selected ' + message);
                        }
                    });

                },
                failure: function () {
                    alert("Failure");
                },
                error: function () {
                    alert("Error");
                }
            });
        }

        function getDown(id) {
            $.ajax({
                url: "http://localhost:5603/api/Employees/GetDownEmployee/" + id,
                type: "GET",
                dataType: "json",
                success: function (result) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'nodeId');
                    data.addColumn('string', 'ParentEntity');
                    data.addColumn('string', 'id');
                    data.addColumn('string', 'ToolTip');
                    for (var i = 0; i < result.length; i++) {
                        if (i == 0) {
                            var parentId = "";
                        }
                        else {
                            var parentId = result[i].parentId.toString();
                        }
                        var id = result[i].id;
                        var nodeId = result[i].nodeId.toString();
                        //var parentId = result[i].parentId.toString() != 0 ? result[i].parentId.toString() : '';
                        var firstName = result[i].firstName;
                        var lastName = result[i].lastName;
                        var department = result[i].department;
                        var jobTitle = result[i].jobTitle;
                        var email = result[i].email;
                        var phone = result[i].phone;
                        var image = result[i].image;
                        var toolTip = "Click for details.";
                        data.addRows([[{
                            v: nodeId,
                            f: '<div style="width:270px;">' +
                                    '<div>' +
                                        '<img src="' + image + '" style="width:75px; height:75px; float:left;"</img>' +
                                    '</div>' +
                                    '<div style="padding-left:90px;">' +
                                        '<div class="name">' + firstName + " " + lastName + '</div>' +
                                        '<div style="color:white; text-align:left;">' + jobTitle + '</div>' +
                                        '<div style="color:white; text-align:left;">' + department + '</div>' +
                                    '</div>' +
                                    '<div>' +
                                    '</br>' +
                                        '<div style="float:left;"><a href="javascript:void(0)" onClick="getUp(' + id + ')"><img src="../images/ArrowUp.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:left;" ><a href="javascript:void(0)" onClick="getDown(' + id + ')"><img src="../images/ArrowDown.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:right;"><a href="javascript:void(0)" onClick="getDetails(' + id + ')"><img src="../images/button.png" style="width:80px;" </img></a></div>' +
                                    '</div>' +
                               '</div>'
                        }, parentId, toolTip, id.toString()]]);
                    }
                    var chart = new google.visualization.OrgChart($("#chart")[0]);
                    chart.draw(data, { allowHtml: true, color: "#E22E2F", selectionColor: "#7D9AB8", allowCollapse: true, size: "medium" });
                    google.visualization.events.addListener(chart, 'select', function () {
                        var selection = chart.getSelection();
                        var message = '';
                        for (var i = 0; i < selection.length; i++) {
                            var item = selection[i];
                            var str = data.getFormattedValue(item.row, 3);
                            message += '{row:' + item.row + ', column:none}; value (col 3) id = ' + str + '\n';
                            //alert('You selected ' + message);
                        }
                    });

                },
                failure: function () {
                    alert("Failure");
                },
                error: function () {
                    alert("Error");
                }
            });
        }

        function getUp(id) {
            $.ajax({
                url: "http://localhost:5603/api/Employees/GetUpEmployee/" + id,
                type: "GET",
                dataType: "json",
                success: function (result) {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', 'nodeId');
                    data.addColumn('string', 'ParentEntity');
                    data.addColumn('string', 'id');
                    data.addColumn('string', 'ToolTip');
                    for (var i = 0; i < result.length; i++) {
                        var parentId = result[i].parentId.toString();
                        if (i == 0) {
                            var parentId = "";
                        }
                        else {
                            var parentId = result[i].parentId.toString();
                        }
                        var id = result[i].id;
                        var nodeId = result[i].nodeId.toString();
                        //var parentId = result[i].parentId.toString() != 0 ? result[i].parentId.toString() : '';
                        var firstName = result[i].firstName;
                        var lastName = result[i].lastName;
                        var department = result[i].department;
                        var jobTitle = result[i].jobTitle;
                        var email = result[i].email;
                        var phone = result[i].phone;
                        var image = result[i].image;
                        var toolTip = "Click for details.";
                        data.addRows([[{
                            v: nodeId,
                            f: '<div style="width:270px;">' +
                                    '<div>' +
                                        '<img src="' + image + '" style="width:75px; height:75px; float:left;"</img>' +
                                    '</div>' +
                                    '<div style="padding-left:90px;">' +
                                        '<div class="name">' + firstName + " " + lastName + '</div>' +
                                        '<div style="color:white; text-align:left;">' + jobTitle + '</div>' +
                                        '<div style="color:white; text-align:left;">' + department + '</div>' +
                                    '</div>' +
                                    '<div>' +
                                    '</br>' +
                                        '<div style="float:left;"><a href="javascript:void(0)" onClick="getUp(' + id + ')"><img src="../images/ArrowUp.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:left;" ><a href="javascript:void(0)" onClick="getDown(' + id + ')"><img src="../images/ArrowDown.png" style="width:25px;"</img></a></div>' +
                                        '<div style="float:right;"><a href="javascript:void(0)" onClick="getDetails(' + id + ')"><img src="../images/button.png" style="width:80px;" </img></a></div>' +
                                    '</div>' +
                               '</div>'
                        }, parentId, toolTip, id.toString()]]);
                    }
                    var chart = new google.visualization.OrgChart($("#chart")[0]);
                    chart.draw(data, { allowHtml: true, color: "#E22E2F", selectionColor: "#7D9AB8", allowCollapse: true, size: "medium" });
                    google.visualization.events.addListener(chart, 'select', function () {
                        var selection = chart.getSelection();
                        var message = '';
                        for (var i = 0; i < selection.length; i++) {
                            var item = selection[i];
                            var str = data.getFormattedValue(item.row, 3);
                            message += '{row:' + item.row + ', column:none}; value (col 3) id = ' + str + '\n';
                            //alert('You selected ' + message);
                        }
                    });

                },
                failure: function () {
                    alert("Failure");
                },
                error: function () {
                    alert("Error");
                }
            });
        }
    </script>
    <style type="text/css">
        .google-visualization-orgchart-node {
            border-width: 0px;
            border-color: #808080;
            border-radius: 15px 15px 15px 15px;
            -webkit-box-shadow: 0px 0px 8px 0px #000000;
            -moz-box-shadow: 0px 0px 8px 0px #000000;
            box-shadow: 0px 0px 7px 0px #000000;
        }

        .google-visualization-orgchart-linenode {
            border-width: 4px;
            border-color: #808080;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="navigation">
            <asp:DropDownList ID="DepartmentDropDownList" runat="server" Style="left: 20px; bottom: 55%; width: 208px; position: absolute;" DataSourceID="SqlDataSource1" DataTextField="departmentName" DataValueField="departmentId" Height="25px" AutoPostBack="True" OnSelectedIndexChanged="DepartmentDropDownList_SelectedIndexChanged"></asp:DropDownList>
            <asp:TextBox ID="searchTextBox" runat="server" Style="left: 20px; bottom: 10%; width: 200px; position: absolute;" ></asp:TextBox>
            <asp:Button ID="searchBtn" runat="server" Text="Search" Style="position: absolute; left: 240px; bottom: 9%;" OnClick="searchBtn_Click" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OrgChartGoogleContext %>" SelectCommand="SELECT departmentId, departmentName FROM Department ORDER BY departmentName"></asp:SqlDataSource>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Search field is required" Style="position: absolute; left:315px; bottom: 11%;" ControlToValidate="searchTextBox" ForeColor="Red">Search field is required</asp:RequiredFieldValidator>
            <asp:ImageButton ID="LogoButton" runat="server" Style="position: relative; top: 0px; left: -1px;" ImageUrl="~/images/csulogo.png" Width="290px" PostBackUrl="~/OrgChart.aspx" CausesValidation="False" />
            <asp:ImageButton ID="AddPersonButton" runat="server" Style="position: absolute; float: right; top: 20%; right: 20px;" ImageUrl="~/images/add.png" Width="45px" Height="45px" PostBackUrl="~/Create.aspx" CausesValidation="False" />
            <asp:ImageButton ID="GridviewButton" runat="server" Style="position: absolute; float: right; top: 20%; right: 100px;" ImageUrl="~/images/grid.png" Width="45px" Height="45px" PostBackUrl="~/GridviewList.aspx" CausesValidation="False" />
        </div>
        <div id="chart" style="padding-top: 8%;">
        </div>
    </form>
</body>
</html>
