using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;

namespace CentroMedico.Models
{
    public class Especialidad
    {
        [Key]
        public int CodigoEspecialidad { get; set; }
        public required string Descripcion { get; set; }
        public int? CodigoEspecialidadPrincipal { get; set; }
    }
}
