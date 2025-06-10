using Microsoft.AspNetCore.Mvc;
using CentroMedico.Models;
using CentroMedico.Data;
using Microsoft.EntityFrameworkCore;

public class PacientesController : Controller
{
    private readonly ApplicationDbContext _context;

    public PacientesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult Crear()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Crear(Paciente paciente)
    {
        if (ModelState.IsValid)
        {
            _context.Paciente.Add(paciente);
            _context.SaveChanges();
            TempData["SuccessMessage"] = "Paciente ingresado exitosamente";
            return RedirectToAction("Index", "Pacientes");
        }
        return View(paciente);
    }

    public async Task<IActionResult> Index()
    {
        var pacientes = await _context.Paciente.ToListAsync();
        return View(pacientes);
    }
}
