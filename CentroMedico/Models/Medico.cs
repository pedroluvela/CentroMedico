using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CentroMedico.Models
{
    public class Medico
    {
        [Key]
        public int CodigoMedico { get; set; }
        public string NombreCompleto { get; set; }
        public DateTime FechaNacimiento { get; set; } // DDMMYYYY
        public string DPI { get; set; }
        public string Colegiado { get; set; }
        public string CodigoVerificacion { get; set; }
        public int EspecialidadId { get; set; }
        public int? SubespecialidadId { get; set; }
        public int? JefeInmediatoId { get; set; }
        public string Sexo { get; set; }
        [ForeignKey("EspecialidadId")]
        public Especialidad? Especialidad { get; set; }

        [ForeignKey("SubespecialidadId")] 
        public Especialidad? Subespecialidad { get; set; }

        [ForeignKey("JefeInmediatoId")]
        public Medico? JefeInmediato { get; set; }
    }
}
