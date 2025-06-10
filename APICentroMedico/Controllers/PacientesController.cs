using APICentroMedico.Data;
using APICentroMedico.DTOs;
using APICentroMedico.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class PacientesController : ControllerBase
{
    private readonly AppDbContext _context;

    public PacientesController(AppDbContext context)
    {
        _context = context;
    }

    // GET: api/pacientes/dpi/1234567890123
    [HttpGet("dpi/{dpi}")]
    public async Task<IActionResult> GetPacientePorDPI(string dpi)
    {
        var paciente = await _context.Paciente.FirstOrDefaultAsync(p => p.DPI == dpi);

        if (paciente == null)
            return NotFound();

        return Ok(paciente);
    }

    // POST: api/pacientes
    [HttpPost]
    public async Task<IActionResult> CrearPaciente([FromBody] PacienteDTO pacienteDTO)
    {
        if (await _context.Paciente.AnyAsync(p => p.DPI == pacienteDTO.DPI))
            return BadRequest("El DPI ya está registrado.");

        var paciente = new Paciente
        {
            NombreCompleto = pacienteDTO.NombreCompleto,
            FechaNacimiento = pacienteDTO.FechaNacimiento,
            Sexo = pacienteDTO.Sexo,
            DPI = pacienteDTO.DPI
        };

        _context.Paciente.Add(paciente);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetPacientePorDPI), new { dpi = paciente.DPI }, paciente);
    }

    // GET: api/pacientes/listado?orden=A
    [HttpGet("listado")]
    public async Task<IActionResult> ListarPacientes([FromQuery] string orden)
    {
        var pacientes = await _context.Paciente.ToListAsync();
        pacientes = orden.ToUpper() == "D"
            ? pacientes.OrderByDescending(p => p.CodigoPaciente).ToList()
            : pacientes.OrderBy(p => p.CodigoPaciente).ToList();

        return Ok(pacientes);
    }
}
