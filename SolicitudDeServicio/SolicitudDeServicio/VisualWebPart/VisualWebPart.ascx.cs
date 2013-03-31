using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using Outlook = Microsoft.Office.Interop.Outlook;
using System.Web;
using System.Data;
using System.Web.UI.WebControls;

namespace SolicitudDeServicio.VisualWebPart
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

        protected void Page_Load(object sender, EventArgs e)
        {
            peopleEditor = new PeopleEditor();
            peopleEditor.AutoPostBack = true;
            peopleEditor.ID = "PeopleEditor1";
            peopleEditor.AllowEmpty = false;
            peopleEditor.MultiSelect = false;
            peopleEditor.ValidatorEnabled = true;
            panel_solicitante.Controls.Add(peopleEditor);
        }

        private SPUser GetCurrentUser()
        {
            if (SPContext.Current.Web.CurrentUser.LoginName.Equals("SHAREPOINT\\system"))
                return SPContext.Current.Web.SiteUsers[HttpContext.Current.User.Identity.Name];

            return SPContext.Current.Web.CurrentUser;
        }

        private void ObtenPropiedadesYGuardaTicket()
        {
            //obtiene el sitio de context
            SPWeb mySite = SPContext.Current.Web;
            //se crea un objeto para la lista catalogo
            SPList list = mySite.Lists["Catalogo"];
            //generamos el querry
            SPQuery query = new SPQuery();
            SPUser currentUser = GetCurrentUser();
            query.Query = "<Query><Where><Eq><FieldRef Name='Usuario'/><Value Type='Text'>" + currentUser + "</Value></Eq></Where></Query>";
            SPListItemCollection myItems = list.GetItems(query);
            //creamos una coleccion de items para guardar en la lista de tickets
            SPListItemCollection listItems = mySite.Lists["Tickets"].Items;
            SPListItem item = listItems.Add();

            foreach (SPListItem Item in myItems)
            {
                Item["Usuario"] = (string)Item["Usuario"];
                Item["Jefe"] = (string)Item["Nombre del Jefe"];
                Item["Tipo Usuario"] = TipoUsuario();
                Item["Nombre Externo"] = panel_solicitante.ToString();
                Item["Ext."] = (string)Item["Ext."];
                Item["Correo"] = (string)Item["Correo"];
                Item["Solicitud"] = txt_solicitud.Text;
                Item["Justificaion"] = txt_justificacion.Text;
                Item["Status"] = "Abierto";
                //Item["Asignado"] = (string)Item["Usuario"];
                //Item["Observaciones"] = (string)Item["Usuario"];
            }
            item.Update();
        }

        private string TipoUsuario()
        {
            string tipoUsuario;
            if (RadioButtonList1.SelectedIndex == 0)
                tipoUsuario = "Usuario Actual";
            tipoUsuario = "Usuario Externo";
            return tipoUsuario;
        }

        protected void btn_guarda_Click(object sender, EventArgs e)
        {
            ObtenPropiedadesYGuardaTicket();
        }

        protected void CustomValidator1_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            if (e.Value.Length == 250)
                e.IsValid = true;
            else
                e.IsValid = false;
        }
        /*private void GuardaTicket()
        {
            SPWeb mySite = SPContext.Current.Web;

            SPListItemCollection listItems = mySite.Lists["Impresiones"].Items;

            SPListItem item = listItems.Add();

            item["Claves"] = Convert.ToString(lineIn.GetValue(0));
            item["Trabajo"] = Convert.ToString(lineIn.GetValue(1));
            item["Pag"] = Convert.ToInt32(lineIn.GetValue(2));
            item["Fecha"] = Convert.ToString(lineIn.GetValue(3));
            Usuario(Convert.ToString(lineIn.GetValue(0)));
            item["Usuario"] = usuario_glo;


            item.Update();
        }*/

        /*private void GetCurrentUserInfo()
        {
            Outlook.AddressEntry addrEntry = Application.Session.CurrentUser.AddressEntry;
            if (addrEntry.Type == "EX")
            {
                Outlook.ExchangeUser currentUser = Application.Session.CurrentUser.
                    AddressEntry.GetExchangeUser();
                if (currentUser != null)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("Name: " + currentUser.Name);
                    sb.AppendLine("STMP address: " + currentUser.PrimarySmtpAddress);
                    sb.AppendLine("Title: " + currentUser.JobTitle);
                    sb.AppendLine("Department: " + currentUser.Department);
                    sb.AppendLine("Location: " + currentUser.OfficeLocation);
                    sb.AppendLine("Business phone: " + currentUser.BusinessTelephoneNumber);
                    sb.AppendLine("Mobile phone: " + currentUser.MobileTelephoneNumber);
                    Debug.WriteLine(sb.ToString());
                }
            }
        }*/
    }
}