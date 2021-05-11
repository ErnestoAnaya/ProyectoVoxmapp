using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ProyectoFinalBaseDatos
{
    /// <summary>
    /// Lógica de interacción para Admin.xaml
    /// </summary>
    public partial class Admin : Window
    {
        public Admin()
        {
            InitializeComponent();
        }

        private void Resultados_Click(object sender, RoutedEventArgs e)
        {
            
            System.Diagnostics.Process.Start("https://docs.google.com/spreadsheets/d/1NrnirdVqhgThFQqfcyC8YquR7ciKqK_j6qingCOUF14/edit?resourcekey#gid=1215732058");

        }

        private void Actualizar_Click(object sender, RoutedEventArgs e)
        {
            ConectarBD con = new ConectarBD();
            string status_act = con.Run_cmd();
            MessageBox.Show(status_act);
        }

        private void Atrás_Click(object sender, RoutedEventArgs e)
        {
            Window main = new MainWindow();
            this.Hide();
            main.Show();
        }
    }
}
