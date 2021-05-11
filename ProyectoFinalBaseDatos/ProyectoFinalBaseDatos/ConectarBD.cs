using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace ProyectoFinalBaseDatos
{
    class ConectarBD
    {
        public string Run_cmd()
        {
            string res;
            string cmd = "C:\\Users\\javi2\\AppData\\Local\\Microsoft\\WindowsApps\\python.exe";
            string filename = @"C:\Users\javi2\Documents\Proyecto Bases de Datos\connectionToPostgres.py";
            string args = "\"" + filename + "\"";
            ProcessStartInfo start = new ProcessStartInfo();
            start.FileName = cmd;//cmd is full path to python.exe
            start.Arguments = args;//args is path to .py file and any cmd line args
            start.UseShellExecute = false; 
            start.RedirectStandardOutput = true;
            using (Process process = Process.Start(start))
            {
                using (StreamReader reader = process.StandardOutput)
                {
                    string result = reader.ReadToEnd();
                    Console.Write(result);
                    res = result;
                }
            }

            return res;
        }
    }

}
