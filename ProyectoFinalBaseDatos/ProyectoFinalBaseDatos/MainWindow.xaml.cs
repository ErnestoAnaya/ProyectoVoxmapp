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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ProyectoFinalBaseDatos
{
    /// <summary>
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Administrador_Click(object sender, RoutedEventArgs e)
        {
            Window admin = new Admin();
            this.Hide();
            admin.Show();
        }

        private void Formulario_Click(object sender, RoutedEventArgs e)
        {
            System.Diagnostics.Process.Start("https://docs.google.com/forms/d/e/1FAIpQLSd5CbzBQqFNUTa35jfb7ZZsuYOc1d57KFX23K0TbrlDxyjLQA/viewform?usp=sf_link");

        }

        private void I_Hospital_Click(object sender, RoutedEventArgs e)
        {
            Window insert_hospital = new Insertar_Hospital();
            this.Hide();
            insert_hospital.Show();
        }
    }
}
