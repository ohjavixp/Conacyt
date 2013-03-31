using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint.WebControls;
using Microsoft.SharePoint;

namespace MesaDeAyuda.VisualWebPart
{
    [ToolboxItemAttribute(false)]
    public partial class VisualWebPart : WebPart
    {
        // Quite los comentarios del siguiente atributo SecurityPermission únicamente cuando ejecute la generación de perfiles de rendimiento en una solución de granja de servidores
        // con el método Instrumentation y, después, quite el atributo SecurityPermission cuando el código esté listo
        // para producción. Dado que el atributo SecurityPermission omite la comprobación de seguridad de los llamadores
        // del constructor, no se recomienda usar en producción.
        // [System.Security.Permissions.SecurityPermission(System.Security.Permissions.SecurityAction.Assert, UnmanagedCode = true)]
        public VisualWebPart()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            InitializeControl();
        }

        private PeopleEditor peopleEditor;

        private void Page_Load(object sender, EventArgs e)
        {
            peopleEditor = new PeopleEditor();
            peopleEditor.AutoPostBack = true;
            peopleEditor.ID = "PeopleEditor1";
            peopleEditor.AllowEmpty = false;
            peopleEditor.MultiSelect = false;
            peopleEditor.ValidatorEnabled = true;
            panel_solicitante.Controls.Add(peopleEditor);

        }

        protected void btn_prueba_Click(object sender, EventArgs e)
        {
            //Insertar elementos a una lista de sharepoint

            SPWeb mySite = SPContext.Current.Web;

            // get the entries that were entered into the people editor and store them in a string

            string NombreSolicitante = peopleEditor.CommaSeparatedAccounts;
            
            // commaseparatedaccounts returns entries that are comma separated. we want to split those up

            char[] splitter = { ',' };

            string[] splitPPData = NombreSolicitante.Split(splitter);

            // this collection will store the user values from the people editor which we'll eventually use
            // to populate the field in the list

            SPFieldUserValueCollection values = new SPFieldUserValueCollection();

            // for each item in our array, create a new sp user object given the loginname and add to our collection

            for (int i = 0; i < splitPPData.Length; i++)
            {
                string loginName = splitPPData[i];

                if (!string.IsNullOrEmpty(loginName))
                {
                    SPUser user = mySite.SiteUsers[loginName];

                    // you could also use 
                    //SPUser user = mySite.EnsureUser(loginName);

                    SPFieldUserValue fuv = new SPFieldUserValue(mySite, user.ID, user.LoginName);

                    values.Add(fuv);
                }
            }

            // set the Person or Group column

            SPListItemCollection listItems = mySite.Lists["MesaDeAyuda"].Items;

            SPListItem item = listItems.Add();




            item["Título"] = txt_titulo.Text;
            item["Nombre del Solicitante Interno"] = values;
            item["Nombre del Solicitante Externo"] = txt_solicitante.Text;
            item["Tipo de Solicitante"] = TipoUsuario();
            item["Organizacion"] = txt_organizacion.Text;
            item["Direccion Adjunta"] = txt_dirAdjunta.Text;
            item["Direccion de Area"] = txt_dirArea.Text;
            item["Subdireccion de Area"] = txt_subDirArea.Text;
            item["Clave de Empleado"] = txt_claveEmple.Text;
            item["Cargo"] = txt_cargo.Text;
            item["No CVU"] = txt_CVU.Text;
            item["Correo Electronico"] = txt_correo.Text;
            item["Telefono"] = txt_tel.Text;
            item["Extension"] = txt_ext.Text;
            item["Oficina"] = lbx_oficina.Text;
            item["Ubicacion Interna"] = lbx_ubicacion.Text;
            item["Ubicacion Externa"] = txt_ubicacionExt.Text;
            item["Descripcion Solicitud"] = txt_descripcion.Text;
            item["Tipo de Servicio"] = lbx_tipoServicio.Text;
            item["Subcategoria de Servicio"] = lbx_subServicio.Text;
            item["Prioridad de Usuario"] = lbx_prioUsuario.Text;
            item["Prioriedad de Resolvedor"] = lbx_prioResolve.Text;
            item["Asignacion"] = lbx_asignacion.Text;

            item.Update();

        }
                
        //funcion que determina que tipo de usuario es
        private string TipoUsuario()
        {
            string tipo;

            if (txt_solicitante.Text == string.Empty)
                tipo = "Estructura";
            tipo = "Interno";
            return tipo;
        }
    }
}
