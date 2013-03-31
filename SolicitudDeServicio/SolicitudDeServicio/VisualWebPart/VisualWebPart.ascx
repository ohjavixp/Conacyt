<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VisualWebPart.ascx.cs" Inherits="SolicitudDeServicio.VisualWebPart.VisualWebPart" %>
<!--libreria people picker-->
<%@ Register TagPrefix="spuc" Namespace="Microsoft.SharePoint.WebControls"
             Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<script type="text/javascript">

    function oculta(id) {
        var elDiv = document.getElementById(id); //se define la variable "elDiv" igual a nuestro div
        elDiv.style.display = 'none'; //damos un atributo display:none que oculta el div	 
    }

    function muestra(id) {
        var elDiv = document.getElementById(id); //se define la variable "elDiv" igual a nuestro div
        elDiv.style.display = 'block';//damos un atributo display:block que  el div	 
    }


    window.onload = function () {/*hace que se cargue la función */
        /* "Mandamos como parametro el nombre de la Div para ocultar" */
        oculta('Pmoral'); /*Ocultamos Pmoral*/
    }
</script>

<table>
    <tr>
        <td>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                <asp:ListItem Selected="False" Value="UsrActual" onclick="oculta('People')">Usuario Actual</asp:ListItem>
                <asp:ListItem Selected="True" Value="UsrExterno" onclick="muestra('People')">Usuario Externo</asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td>
            <div id="People">
                <style  type="text/css">    
                                .ms-inputuserfield{ font-size:8pt; font-family:Verdana,sans-serif; border:1px solid #a5a5a5;}  
                                div.ms-inputuserfield a{color:#000000;text-decoration: none;font-weight:normal;font-style:normal;}    
                                div.ms-inputuserfield{padding-left:1px;padding-top:2px;}    
                                        </style>
                            <asp:Panel ID="panel_solicitante" runat="server" Width="350px" OnLoad="panel_solicitante_Load"></asp:Panel>
            </div>
            
        </td>
    </tr>
    <tr>
        <td>Solicitud</td>
        <td>
            <asp:TextBox ID="txt_solicitud" runat="server" Height="81px" Width="336px" TextMode="MultiLine"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>Justificacion</td>
        <td>
            <asp:TextBox ID="txt_justificacion" runat="server" Height="76px" Width="335px" Rows="1" TextMode="MultiLine"></asp:TextBox>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
            <asp:Button ID="btn_guarda" runat="server" Text="Guardar" OnClick="btn_guarda_Click" />
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txt_solicitud" ErrorMessage="El campo Solicitud debe de contener un maximo de 250 caracteres" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            <br />
            <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txt_solicitud" ErrorMessage="El campo Justificacion debe de contener un maximo de 250 caracteres" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
        </td>
    </tr>
</table>