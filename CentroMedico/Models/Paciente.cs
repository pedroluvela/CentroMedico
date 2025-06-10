using System.ComponentModel.DataAnnotations;

namespace CentroMedico.Models
{
    public class Paciente
    {
        [Key]
        public int CodigoPaciente { get; set; }
        public string NombreCompleto { get; set; }
        public DateTime FechaNacimiento { get; set; } // DDMMYYYY
        public string DPI { get; set; }
        public string Sexo { get; set; }
    }
}
