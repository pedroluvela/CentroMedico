-- Consultas SQL para estadísticas:

-- 1. Total de consultas en progreso por especialidad
SELECT
    E.Descripcion AS Especialidad,
    COUNT(C.CodigoCita) AS TotalConsultasEnProgreso
FROM
    Cita C
JOIN
    Medico M ON C.CodigoMedico = M.CodigoMedico
JOIN
    Especialidad E ON M.EspecialidadId = E.CodigoEspecialidad
JOIN
    EstadoCita EC ON C.CodigoEstadoCita = EC.CodigoEstado
WHERE
    EC.Descripcion = 'En Progreso'
GROUP BY
    E.Descripcion
ORDER BY
    TotalConsultasEnProgreso DESC;

-- 2. Total de consultas pendientes por médico
SELECT
    M.NombreCompleto AS Medico,
    COUNT(C.CodigoCita) AS TotalConsultasPendientes
FROM
    Cita C
JOIN
    Medico M ON C.CodigoMedico = M.CodigoMedico
JOIN
    EstadoCita EC ON C.CodigoEstadoCita = EC.CodigoEstado
WHERE
    EC.Descripcion = 'Pendiente'
GROUP BY
    M.NombreCompleto
ORDER BY
    TotalConsultasPendientes DESC;

-- 3. La consulta con mayor duración en minutos, incluir el nombre del paciente y médico tratante
SELECT TOP 1
    P.NombreCompleto AS Paciente,
    M.NombreCompleto AS MedicoTratante,
    C.FechaHoraInicio,
    C.FechaHoraFin,
    DATEDIFF(minute, C.FechaHoraInicio, C.FechaHoraFin) AS DuracionEnMinutos
FROM
    Cita C
JOIN
    Paciente P ON C.CodigoPaciente = P.CodigoPaciente
JOIN
    Medico M ON C.CodigoMedico = M.CodigoMedico
WHERE
    C.FechaHoraFin IS NOT NULL
ORDER BY
    DuracionEnMinutos DESC;

-- 4. La consulta con menor duración en segundos, incluir el nombre del paciente y médico tratante
SELECT TOP 1
    P.NombreCompleto AS Paciente,
    M.NombreCompleto AS MedicoTratante,
    C.FechaHoraInicio,
    C.FechaHoraFin,
    DATEDIFF(second, C.FechaHoraInicio, C.FechaHoraFin) AS DuracionEnSegundos
FROM
    Cita C
JOIN
    Paciente P ON C.CodigoPaciente = P.CodigoPaciente
JOIN
    Medico M ON C.CodigoMedico = M.CodigoMedico
WHERE
    C.FechaHoraFin IS NOT NULL
ORDER BY
    DuracionEnSegundos ASC;

-- 5. El cliente con más medicamentos recetados
SELECT TOP 1
    P.NombreCompleto AS Paciente,
    COUNT(CM.CodigoMedicamento) AS TotalMedicamentosRecetados
FROM
    ConsultaMedicamento CM
JOIN
    Cita C ON CM.CodigoCita = C.CodigoCita
JOIN
    Paciente P ON C.CodigoPaciente = P.CodigoPaciente
GROUP BY
    P.NombreCompleto
ORDER BY
    TotalMedicamentosRecetados DESC;

-- 6. El médico hombre que ha atendido a más pacientes mujeres
SELECT TOP 1
    M.NombreCompleto AS MedicoHombre,
    COUNT(DISTINCT P.CodigoPaciente) AS TotalPacientesMujeresAtendidas
FROM
    Cita C
JOIN
    Medico M ON C.CodigoMedico = M.CodigoMedico
JOIN
    Paciente P ON C.CodigoPaciente = P.CodigoPaciente
WHERE
    M.Sexo = 'M' AND P.Sexo = 'F'
GROUP BY
    M.NombreCompleto
ORDER BY
    TotalPacientesMujeresAtendidas DESC;

-- 7. Cada subespecialidad con el total de consultas realizadas por pacientes hombres
SELECT
    E.Descripcion AS Subespecialidad,
    COUNT(C.CodigoCita) AS TotalConsultasPacientesHombres
FROM
    Cita C
JOIN
    Medico M ON C.CodigoMedico = M.CodigoMedico
JOIN
    Especialidad E ON M.SubespecialidadId = E.CodigoEspecialidad -- Unimos con la subespecialidad
JOIN
    Paciente P ON C.CodigoPaciente = P.CodigoPaciente
WHERE
    P.Sexo = 'M' AND M.SubespecialidadId IS NOT NULL -- Aseguramos que tenga subespecialidad
GROUP BY
    E.Descripcion
ORDER BY
    TotalConsultasPacientesHombres DESC;