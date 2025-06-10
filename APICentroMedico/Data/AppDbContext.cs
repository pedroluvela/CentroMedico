using APICentroMedico.Models;
using Microsoft.EntityFrameworkCore;

namespace APICentroMedico.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Paciente> Paciente { get; set; }
    }

}
