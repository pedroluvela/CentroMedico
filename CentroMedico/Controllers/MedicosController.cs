using CentroMedico.Data;
using CentroMedico.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

public class MedicosController : Controller
{
    private readonly ApplicationDbContext _context;

    public MedicosController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> Crear()
    {
        var especialidades = await _context.Especialidad.ToListAsync();
        ViewBag.EspecialidadId = new SelectList(especialidades, "CodigoEspecialidad", "Descripcion");
        var subEspecialidades = await _context.Especialidad
                                              .Where(e => e.CodigoEspecialidadPrincipal.HasValue)
                                              .ToListAsync();
        ViewBag.SubespecialidadId = new SelectList(subEspecialidades, "CodigoEspecialidad", "Descripcion");
        var jefesinmediatos = await _context.Medico.ToListAsync();
        ViewBag.JefeInmediatoId = new SelectList(jefesinmediatos, "CodigoMedico", "NombreCompleto");
        return View();
    }

    [HttpPost]
    public IActionResult Crear(Medico medico)
    {
        if (ModelState.IsValid)
        {
            _context.Medico.Add(medico);
            _context.SaveChanges();
            TempData["SuccessMessage"] = "Médico ingresado exitosamente";
            return RedirectToAction("Index", "Medicos");
        }
        return View(medico);
    }
    public async Task<IActionResult> Index()
    {
        var medicos = await _context.Medico
                                    .Include(m => m.Especialidad)
                                    .Include(m => m.Subespecialidad)
                                    .Include(m => m.JefeInmediato)
                                    .ToListAsync();
        return View(medicos); 
    }
}
