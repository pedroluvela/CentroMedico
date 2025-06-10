using CentroMedico.Data;
using CentroMedico.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

public class CitasController : Controller
{
    private readonly ApplicationDbContext _context;

    public CitasController(ApplicationDbContext context)
    {
        _context = context;
    }
    public async Task<IActionResult> Index()
    {
        var citas = await _context.Cita
                                    .Include(m => m.Paciente)
                                    .Include(m => m.Medico)
                                    .Include(m => m.EstadoCita)
                                    .Include(m => m.Anexos)
                                    .ToListAsync();
        return View(citas); 
    }
    [HttpGet]
    public async Task<IActionResult> Crear()
    {
        var pacientes = await _context.Paciente.ToListAsync();
        ViewBag.Pacientes = new SelectList(pacientes, "CodigoPaciente", "NombreCompleto");
        var medicos = await _context.Medico.ToListAsync();
        ViewBag.medicos = new SelectList(medicos, "CodigoMedico", "NombreCompleto");
        var estados = await _context.EstadoCita.ToListAsync();
        ViewBag.estados = new SelectList(estados, "CodigoEstado", "Descripcion");
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> Crear(Cita cita, List<IFormFile> archivos)
    {
        try
        {
            if (ModelState.IsValid)
            {
                _context.Cita.Add(cita);
                await _context.SaveChangesAsync();
                var rutaBase = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "anexos", $"cita_{cita.CodigoCita}");
                Directory.CreateDirectory(rutaBase);

                foreach (var archivo in archivos)
                {
                    if (archivo.Length > 0)
                    {
                        var nombreArchivo = Path.GetFileName(archivo.FileName);
                        var rutaCompleta = Path.Combine(rutaBase, nombreArchivo);

                        using (var stream = new FileStream(rutaCompleta, FileMode.Create))
                        {
                            await archivo.CopyToAsync(stream);
                        }

                        var anexo = new Anexo
                        {
                            NombreArchivo = nombreArchivo,
                            RutaArchivo = $"/anexos/cita_{cita.CodigoCita}/{nombreArchivo}",
                            TipoContenido = archivo.ContentType,
                            CodigoCita = cita.CodigoCita
                        };

                        _context.Anexo.Add(anexo);
                    }
                }
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Cita ingresada exitosamente";
            }            
        }
        catch (UnauthorizedAccessException ex)
        {
            Console.WriteLine($"Permiso denegado al intentar subir el archivo: {ex.Message}");
            ModelState.AddModelError("", "Error: Permiso denegado al intentar guardar el archivo. Por favor, contacte al administrador.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error al subir el archivo: {ex.Message}");
            ModelState.AddModelError("", "Ocurrió un error inesperado al subir el archivo. Por favor, intente de nuevo.");
        }
        return RedirectToAction("Index", "Citas");
    }
    public async Task<IActionResult> VerAnexos(int id)
    {
        var cita = await _context.Cita
            .Include(c => c.Paciente)
            .Include(c => c.Anexos)
            .FirstOrDefaultAsync(c => c.CodigoCita == id);

        if (cita == null)
        {
            return NotFound();
        }

        return View(cita);
    }
}
