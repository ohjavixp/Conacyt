<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VisualWebPart.ascx.cs" Inherits="MesaDeAyuda.VisualWebPart.VisualWebPart" %>

<!--libreria people picker-->

<%@ Register TagPrefix="spuc" Namespace="Microsoft.SharePoint.WebControls"
             Assembly="Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Smart Wizard 2 - Basic Example  - a javascript jQuery wizard control plugin</title>

<link href="../_Layouts/MesaDeAyuda/styles/smart_wizard.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../_Layouts/MesaDeAyuda/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../_Layouts/MesaDeAyuda/js/jquery.smartWizard-2.0.js"></script>

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


<script type="text/javascript">
    $(document).ready(function () {
        // Smart Wizard 	
        $('#wizard').smartWizard({
            // Properties  
            enableAllSteps: false,  // Enable/Disable all steps on first load
            transitionEffect: 'slideleft', // Effect on navigation, none/fade/slide/slideleft
            enableFinishButton: false, // makes finish button enabled always
            labelNext: 'Siguiente', // label for Next button
            labelPrevious: 'Anteriro', // label for Previous button
            labelFinish: 'Finalizar',  // label for Finish button        
            // Events
            onLeaveStep: null, // triggers when leaving a step
            onShowStep: null,  // triggers when showing a step
            onFinish: null  // triggers when Finish button is clicked
        });

        function onFinishCallback() {
            if (validateAllSteps()) {
                $('form').submit();
            }
        }
    });
</script>

    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 160px;
        }
        </style>

</head><body>

<table align="center" border="0" cellpadding="0" cellspacing="0">
<tr><td> 
<!-- Smart Wizard -->
  		<div id="wizard" class="swMain">
  			<ul>
  				<li><a href="#step-1">
                <label class="stepNumber">1</label>
                <span class="stepDesc">
                   Nuevo Servicio<br />
                   <small>Nuevo Elemento</small>
                </span>
            </a></li>
  				<li><a href="#step-2">
                <label class="stepNumber">2</label>
                <span class="stepDesc">
                   Tipo Solicitante<br />
                   <small>Selecciona:</small>
                </span>
            </a></li>
  				<li><a href="#step-3">
                <label class="stepNumber">3</label>
                <span class="stepDesc">
                   Tipo Solicitante<br />
                   <small><!--descripcion--></small>
                </span>                   
             </a></li>
  				<li><a href="#step-4">
                <label class="stepNumber">4</label>
                <span class="stepDesc">
                   Step 4<br />
                   <small>Step 4 description</small>
                </span>                   
            </a></li>
  			</ul>
              <!--Contenido-->
  			<div id="step-1">	
            <h2 class="StepTitle">Nuevo Servicio: Nuevo Elemento</h2>      			
                <table class="auto-style1">
                    <tr>
                        <td class="auto-style2">Titulo de Incidencia</td>
                        <td>
                            <asp:TextBox ID="txt_titulo" runat="server" Width="350px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Tipo de Solicitante</td>
                        <td>
                            <label>
                                <input type="radio" name="pers_cte" value="Estructura" onfocus="0"  id="Radio1" checked="checked"  onclick="muestra('PEstructura'); oculta('PExterno')"> <!-- Al cambiar 
                                "onClick" el valor del radio llamamos la funcion ocultando los campos de PExterno y mostrando PEstructura-->
                                    Estructura</label>
                             <br/>
                             <br/>
                             <label>
                                <input type="radio" name="pers_cte" value="Externo" id="Radio2" onclick="muestra('PExterno'); oculta('PEstructura')"/>
                                Externo</label>
                            
                            <asp:Button ID="btn_prueba" runat="server" Text="Button" OnClick="btn_prueba_Click" />
                        </td>
                    </tr>
                    </table>			
        </div>
  			<div id="step-2">
            <h2 class="StepTitle">Datos Generales</h2>
                  <div id="PEstructura">
                        <table class="auto-style1">
                            <tr>
                                <td class="auto-style5">Nombre del Solicitante</td>
                                <td>
                                    <style  type="text/css">    
                                .ms-inputuserfield{ font-size:8pt; font-family:Verdana,sans-serif; border:1px solid #a5a5a5;}  
                                div.ms-inputuserfield a{color:#000000;text-decoration: none;font-weight:normal;font-style:normal;}    
                                div.ms-inputuserfield{padding-left:1px;padding-top:2px;}    
                                        .auto-style5 {
                                            width: 237px;
                                        }
                                        .auto-style6 {
                                            width: 239px;
                                        }
                            </style>
                            <asp:Panel ID="panel_solicitante" runat="server" Width="350px"></asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Organizacion</td>
                                <td>
                                    <asp:TextBox ID="txt_organizacion" runat="server"  Width="350px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Direccion Adjunta</td>
                                <td>
                                    <asp:TextBox ID="txt_dirAdjunta" runat="server"  Width="350px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Direccion de Area</td>
                                <td>
                                    <asp:TextBox ID="txt_dirArea" runat="server"  Width="350px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Subdireccion de Area</td>
                                <td>
                                    <asp:TextBox ID="txt_subDirArea" runat="server"  Width="350px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Clave de Empleado</td>
                                <td>
                                    <asp:TextBox ID="txt_claveEmple" runat="server"  Width="350px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Oficina</td>
                                <td>
                                    <asp:ListBox ID="lbx_oficina" runat="server" Height="22px" Width="350px"></asp:ListBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">Ubicacion Interna</td>
                                <td>
                                    <asp:ListBox ID="lbx_ubicacion" runat="server" Height="22px" Width="350px"></asp:ListBox>
                                </td>
                            </tr>                            
                        </table>
                    
                    </div>
                    
                    <div id="PExterno">
                    <table class="auto-style1">                   
                        <tr>
                            <td class="auto-style6">Nombre del Solicitante</td>
                            <td>
                                <asp:TextBox ID="txt_solicitante" runat="server" Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Cargo</td>
                            <td>
                                <asp:TextBox ID="txt_cargo" runat="server"  Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">No. CVU</td>
                            <td>
                                <asp:TextBox ID="txt_CVU" runat="server"  Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Correo Electronico</td>
                            <td>
                                <asp:TextBox ID="txt_correo" runat="server"  Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Telefono</td>
                            <td>
                                <asp:TextBox ID="txt_tel" runat="server"  Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Extension</td>
                            <td>
                                <asp:TextBox ID="txt_ext" runat="server"  Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Ubicacion Externa</td>
                            <td>
                                <asp:TextBox ID="txt_ubicacionExt" runat="server"  Width="350px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    </div>
            </div>     
            <!---------------------- 3 -------------------->                          
  			<div id="step-3">
            <h2 class="StepTitle">Descripcion de la Solicitud</h2>
                <table class="auto-style1">
                    <tr>
                        <td>Descripcion de la Solicitud</td>
                        <td>
                                <asp:TextBox ID="txt_descripcion" runat="server"  Width="350px" Height="73px"></asp:TextBox>
                            </td>
                    </tr>
                    <tr>
                        <td>Tipo de Servicio</td>
                        <td>
                            <asp:ListBox ID="lbx_tipoServicio" runat="server" Width="350px" Height="22px"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Subcategoria de Servicio</td>
                        <td>
                            <asp:ListBox ID="lbx_subServicio" runat="server" Width="350px" Height="22px"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Prioriedad de usuario</td>
                        <td>
                            <asp:ListBox ID="lbx_prioUsuario" runat="server" Width="350px" Height="22px"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Prioriedad de Resolvedor</td>
                        <td>
                            <asp:ListBox ID="lbx_prioResolve" runat="server" Width="350px" Height="22px"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Asignacion</td>
                        <td>
                            <asp:ListBox ID="lbx_asignacion" runat="server" Width="350px" Height="22px"></asp:ListBox>
                        </td>
                    </tr>
                    </table>

                                      				            
            </div>
            <!-------------------- 4 -------------------->
  			<div id="step-4">
            <h2 class="StepTitle">Asignacion</h2>
        </div>
  		</div>
<!-- End SmartWizard Content -->  		
 		
</td></tr>
</table>


    		
</body>
</html>