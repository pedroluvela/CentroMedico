using System.ComponentModel.DataAnnotations;

namespace APICentroMedico.Models
{
    public class Paciente
    {
        [Key]
        public int CodigoPaciente { get; set; }
        public string NombreCompleto { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public string DPI { get; set; }
    }
}
