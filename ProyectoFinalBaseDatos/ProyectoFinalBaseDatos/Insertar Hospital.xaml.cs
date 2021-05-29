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
    /// Lógica de interacción para Insertar_Hospital.xaml
    /// </summary>
    public partial class Insertar_Hospital : Window
    {
        public Insertar_Hospital()
        {
            InitializeComponent();
        }

        private void insert_b_Click(object sender, RoutedEventArgs ev)
        {
            string a = moph_tb.Text;
            string b = name_tb.Text;
            string c = district_tb.Text;
            string d = province_tb.Text;
            string e = type_tb.Text;
            string f = longitude_tb.Text;
            string g = latitude_tb.Text;
            string h = altitude_tb.Text;
            string i = "date";
            string j = personal_vm_id_tb.Text;
            string k = num_doctors_tb.Text;
            string l = num_staff_tb.Text;
            string m = label_tb.Text;

            string[] arg = { a, b, c, d, e, f, g, h, i, j, k, l, m };


            ConectarBD con = new ConectarBD();
            string status_act = con.Run_cmd_args(arg);
            if (status_act == "")
                MessageBox.Show("Hospital was succesfully added.");
            else
                MessageBox.Show(status_act);

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Window main = new MainWindow();
            this.Hide();
            main.Show();
        }
    }
}
