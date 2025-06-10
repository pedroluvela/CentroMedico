using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CentroMedico.Models
{
    public class Anexo
    {
        [Key]
        public int CodigoAnexo { get; set; }
        public string NombreArchivo { get; set; }
        public string RutaArchivo { get; set; }
        public string TipoContenido { get; set; }
        public int CodigoCita { get; set; }
        [ForeignKey("CodigoCita")]
        public Cita Cita { get; set; }
    }
}
