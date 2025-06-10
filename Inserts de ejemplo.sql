-- Inserts de ejemplo
-- Tabla: Especialidad
INSERT INTO Especialidad (Descripcion, CodigoEspecialidadPrincipal) VALUES
('Medicina General', NULL),
('Cardiología', NULL),
('Pediatría', NULL),
('Dermatología', NULL),
('Gastroenterología', NULL),
('Medicina Interna', 1), -- Subespecialidad de Medicina General (ejemplo, puede ser una especialidad por sí misma)
('Cardiología Pediátrica', 2), -- Subespecialidad de Cardiología
('Dermatología Cosmética', 4); -- Subespecialidad de Dermatología

-- Tabla: Paciente
INSERT INTO Paciente (NombreCompleto, FechaNacimiento, Sexo, DPI) VALUES
('Maria Lopez Garcia', '1985-03-15', 'F', '2987654321010'),
('Juan Perez Gonzalez', '1990-07-22', 'M', '1234567890123'),
('Ana Ramirez Soto', '1978-11-30', 'F', '3012345678901'),
('Carlos Fuentes Diaz', '2000-01-05', 'M', '2567890123456'),
('Laura Morales Ruiz', '1995-09-10', 'F', '1987654321987');

-- Tabla: EstadoCita
INSERT INTO EstadoCita (Descripcion) VALUES
('Pendiente'),
('En Progreso'),
('Finalizada'),
('Cancelada');

-- Tabla: Medico
-- Codigo de Verificacion: 4 digitos mayores en orden descendente del DPI
-- Medico 1: Dr. Pedro Martinez (DPI: 1234567890001 -> CodigoVerificacion: 9876) Especialidad: Cardiología
INSERT INTO Medico (NombreCompleto, DPI, Colegiado, Sexo, FechaNacimiento, CodigoVerificacion, EspecialidadId, SubespecialidadId, JefeInmediatoId) VALUES
('Pedro Martinez Solis', '1234567890001', 'C-12345', 'M', '1970-04-20', '9876', 2, NULL, NULL);

-- Medico 2: Dra. Sofia Castro (DPI: 9876543210002 -> CodigoVerificacion: 9876) Especialidad: Pediatría
INSERT INTO Medico (NombreCompleto, DPI, Colegiado, Sexo, FechaNacimiento, CodigoVerificacion, EspecialidadId, SubespecialidadId, JefeInmediatoId) VALUES
('Sofia Castro Ruiz', '9876543210002', 'C-54321', 'F', '1980-01-10', '9876', 3, NULL, 1); -- JefeInmediato: Pedro Martinez

-- Medico 3: Dr. Andres Gomez (DPI: 7654321090003 -> CodigoVerificacion: 7654) Especialidad: Dermatología, Subespecialidad: Dermatología Cosmética
INSERT INTO Medico (NombreCompleto, DPI, Colegiado, Sexo, FechaNacimiento, CodigoVerificacion, EspecialidadId, SubespecialidadId, JefeInmediatoId) VALUES
('Andres Gomez Fuentes', '7654321090003', 'C-67890', 'M', '1975-06-25', '7654', 4, 8, 1);

-- Medico 4: Dr. Ricardo Salas (DPI: 4567891230004 -> CodigoVerificacion: 9876) Especialidad: Medicina General, Subespecialidad: Medicina Interna
INSERT INTO Medico (NombreCompleto, DPI, Colegiado, Sexo, FechaNacimiento, CodigoVerificacion, EspecialidadId, SubespecialidadId, JefeInmediatoId) VALUES
('Ricardo Salas Vargas', '4567891230004', 'C-11223', 'M', '1982-08-18', '9876', 1, 6, 2);

-- Medico 5: Dra. Elena Perez (DPI: 3210987650005 -> CodigoVerificacion: 9876) Especialidad: Cardiología, Subespecialidad: Cardiología Pediátrica
INSERT INTO Medico (NombreCompleto, DPI, Colegiado, Sexo, FechaNacimiento, CodigoVerificacion, EspecialidadId, SubespecialidadId, JefeInmediatoId) VALUES
('Elena Perez Torres', '3210987650005', 'C-99887', 'F', '1988-12-01', '9876', 2, 7, 1);

-- Tabla: Cita
INSERT INTO Cita (CodigoPaciente, CodigoMedico, FechaHoraInicio, FechaHoraFin, CodigoEstadoCita, FechaProximaCita) VALUES
-- Citas en progreso
(1, 1, '2025-06-08 10:00:00', NULL, 2, NULL), -- Maria Lopez con Dr. Martinez (Cardiología)
(2, 3, '2025-06-08 11:30:00', NULL, 2, NULL), -- Juan Perez con Dr. Gomez (Dermatología)

-- Citas pendientes
(3, 2, '2025-06-10 09:00:00', NULL, 1, '2025-07-10 09:00:00'), -- Ana Ramirez con Dra. Castro (Pediatría)
(4, 4, '2025-06-10 14:00:00', NULL, 1, NULL), -- Carlos Fuentes con Dr. Salas (Medicina General)
(1, 2, '2025-06-11 10:00:00', NULL, 1, NULL), -- Maria Lopez con Dra. Castro (Pediatría)

-- Citas finalizadas con duracion variable (para mayor/menor duracion)
(5, 1, '2025-06-07 09:00:00', '2025-06-07 09:30:00', 3, NULL), -- Laura Morales (F) con Dr. Martinez (M) - 30 mins
(2, 2, '2025-06-07 10:00:00', '2025-06-07 10:01:00', 3, NULL), -- Juan Perez (M) con Dra. Castro (F) - 1 min (60 seg)
(1, 3, '2025-06-06 14:00:00', '2025-06-06 14:00:10', 3, NULL), -- Maria Lopez (F) con Dr. Gomez (M) - 10 seg (menor duracion)
(3, 4, '2025-06-05 08:00:00', '2025-06-05 09:40:00', 3, NULL), -- Ana Ramirez (F) con Dr. Salas (M) - 100 mins (mayor duracion)
(5, 5, '2025-06-04 11:00:00', '2025-06-04 11:25:00', 3, NULL), -- Laura Morales (F) con Dra. Elena Perez (F) - 25 mins
(2, 4, '2025-06-03 16:00:00', '2025-06-03 16:15:00', 3, NULL); -- Juan Perez (M) con Dr. Salas (M) - 15 mins

-- Tabla: Anexo
INSERT INTO Anexo (NombreArchivo, RutaArchivo, TipoContenido, CodigoCita) VALUES
('resultado_sangre_maria.pdf', '/anexos/maria/sangre.pdf', 'application/pdf', 6),
('rx_juan.jpg', '/anexos/juan/rx.jpg', 'image/jpeg', 7);

-- Tabla: Medicamento
INSERT INTO Medicamento (Nombre, Descripcion) VALUES
('Paracetamol', 'Analgésico y antipirético'),
('Amoxicilina', 'Antibiótico'),
('Ibuprofeno', 'Antiinflamatorio no esteroideo'),
('Omeprazol', 'Inhibidor de la bomba de protones'),
('Atorvastatina', 'Medicamento para reducir el colesterol');

-- Tabla: ConsultaMedicamento
INSERT INTO ConsultaMedicamento (CodigoCita, CodigoMedicamento, Dosis, Frecuencia, Duracion) VALUES
-- Paciente 1 (Maria Lopez) - 3 medicamentos
(6, 1, '500 mg', 'Cada 8 horas', '7 días'),
(6, 4, '20 mg', 'Cada 24 horas', '30 días'),
(1, 2, '250 mg', 'Cada 12 horas', '10 días'), -- Agregado a cita en progreso

-- Paciente 2 (Juan Perez) - 2 medicamentos
(7, 1, '500 mg', 'Cada 8 horas', '5 días'),
(7, 3, '400 mg', 'Cada 6 horas', '3 días'),

-- Paciente 3 (Ana Ramirez) - 1 medicamento
(9, 5, '10 mg', 'Cada 24 horas', '90 días'),

-- Paciente 5 (Laura Morales) - 2 medicamentos
(10, 1, '500 mg', 'Cada 8 horas', '7 días'),
(10, 2, '500 mg', 'Cada 8 horas', '7 días');

