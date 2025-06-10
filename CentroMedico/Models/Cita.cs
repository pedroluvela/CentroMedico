using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CentroMedico.Models
{
    public class Cita
    {
        [Key]
        public int CodigoCita { get; set; }
        public int CodigoPaciente { get; set; }
        public int CodigoMedico { get; set; }
        public DateTime FechaHoraInicio { get; set; }
        public DateTime FechaHoraFin { get; set; }
        public int CodigoEstadoCita { get; set; }
        public DateTime? FechaProximaCita { get; set; }      
        [ForeignKey("CodigoPaciente")]
        public Paciente? Paciente { get; set; }

        [ForeignKey("CodigoMedico")] 
        public Medico? Medico { get; set; }

        [ForeignKey("CodigoEstadoCita")]
        public EstadoCita? EstadoCita { get; set; }
        public List<Anexo> Anexos { get; set; } = new();
    }   
}
