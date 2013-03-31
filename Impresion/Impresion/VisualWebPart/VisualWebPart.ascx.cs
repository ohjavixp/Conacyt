using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using System.IO;
using System.Data;

namespace Impresion.VisualWebPart
{
    [ToolboxItemAttribute(false)]
    public partial class VisualWebPart : WebPart
    {
        public string usuario_glo;

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

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            string savePath = @"c:\Temp\uploads\";
            if (FileUploadControl.HasFile)
            {

                string nombreArchivo = FileUploadControl.FileName;
                try
                {
                    //string filename = System.IO.Path.GetFileName(FileUploadControl.FileName);
                    //savePath += nombreArchivo;

                    // Get the extension of the uploaded file.
                    string extension = System.IO.Path.GetExtension(nombreArchivo);

                    if (extension == ".csv")
                    {
                        if (FileUploadControl.PostedFile.ContentLength < 50100000)
                        {
                            FileUploadControl.SaveAs(savePath + "impresion.csv");
                            StatusLabel.Text = "Estado de la Carga: Archivo Cargado! " + nombreArchivo;
                        }
                        else
                            StatusLabel.Text = "Estado de la Carga: El CSV debe de pesar menos de 50 Mb!";
                    }
                    else
                        StatusLabel.Text = "Estado de la Carga: Solo archivos .CSV son aceptados!";
                }
                catch (Exception ex)
                {
                    StatusLabel.Text = "Estado de la Carga: El Archivo no sera Cargado. Error: " + ex.Message;
                }

                loadCsvData(nombreArchivo);
            }
        }

        private void loadCsvData(string fileName)
        {
            string savePath = @"c:\Temp\uploads\impresion.csv";
            FileInfo fileIn = new FileInfo(savePath);

            StreamReader reader = fileIn.OpenText();
            string[] lineIn;

            while (!reader.EndOfStream)
            {
                lineIn = reader.ReadLine().Split(',');
                //Validate values here
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
            }

            reader.Close();
        }

        private void Usuario(string clave)
        {
            SPWeb mySite = SPContext.Current.Web;
            SPList list = mySite.Lists["Usuarios"];

            SPQuery query = new SPQuery();
            query.Query = "<Query><Where><Eq><FieldRef Name='Clave'/><Value Type='Text'>" + clave + "</Value></Eq></Where></Query>";

            SPListItemCollection myItems = list.GetItems(query);

            foreach (SPListItem item in myItems)
            {
                usuario_glo = (string)item["Usuario"];
            }
        }
    }
}
