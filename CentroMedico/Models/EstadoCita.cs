using System.ComponentModel.DataAnnotations;

namespace CentroMedico.Models
{
    public class EstadoCita
    {
        [Key]
        public int CodigoEstado { get; set; }
        public string Descripcion { get; set; }     
    }
}
