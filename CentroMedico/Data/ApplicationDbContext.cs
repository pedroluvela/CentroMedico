using CentroMedico.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace CentroMedico.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

    public DbSet<Medico> Medico { get; set; }
    public DbSet<Paciente> Paciente { get; set; }
    public DbSet<Especialidad> Especialidad { get; set; }
    public DbSet<Cita> Cita { get; set; }
    public DbSet<EstadoCita> EstadoCita { get; set; }
    public DbSet<Anexo> Anexo { get; set; }
}
