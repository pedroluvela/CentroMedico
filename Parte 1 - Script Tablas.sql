CREATE TABLE Paciente (
    CodigoPaciente INT PRIMARY KEY IDENTITY(1,1),
    NombreCompleto NVARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    DPI CHAR(13) NOT NULL UNIQUE
);
CREATE TABLE Especialidad (
    CodigoEspecialidad INT PRIMARY KEY IDENTITY(1,1),
    Descripcion NVARCHAR(100) NOT NULL,
    CodigoEspecialidadPrincipal INT NULL,
    FOREIGN KEY (CodigoEspecialidadPrincipal) REFERENCES Especialidad(CodigoEspecialidad)
);
CREATE TABLE Medico (
    CodigoMedico INT PRIMARY KEY IDENTITY(1,1),
    NombreCompleto NVARCHAR(100) NOT NULL,
    DPI CHAR(13) NOT NULL UNIQUE,
    Colegiado NVARCHAR(20) NOT NULL,
    Sexo CHAR(1) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    CodigoVerificacion NVARCHAR(50),
    EspecialidadId INT NULL,
    SubespecialidadId INT NULL,
    JefeInmediatoId INT NULL,
    FOREIGN KEY (EspecialidadId) REFERENCES Especialidad(CodigoEspecialidad),
    FOREIGN KEY (SubespecialidadId) REFERENCES Especialidad(CodigoEspecialidad),
    FOREIGN KEY (JefeInmediatoId) REFERENCES Medico(CodigoMedico)
);
CREATE TABLE EstadoCita (
    CodigoEstado INT PRIMARY KEY IDENTITY(1,1),
    Descripcion NVARCHAR(50)
);
CREATE TABLE Cita (
    CodigoCita INT PRIMARY KEY IDENTITY(1,1),
    CodigoPaciente INT NOT NULL,
    CodigoMedico INT NOT NULL,
    FechaHoraInicio DATETIME NOT NULL,
    FechaHoraFin DATETIME NULL,
    CodigoEstadoCita INT NOT NULL,
    FechaProximaCita DATETIME NULL,
    FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(CodigoPaciente),
    FOREIGN KEY (CodigoMedico) REFERENCES Medico(CodigoMedico),
    FOREIGN KEY (CodigoEstadoCita) REFERENCES EstadoCita(CodigoEstadoCita)
);
CREATE TABLE Anexo (
    CodigoAnexo INT IDENTITY(1,1) PRIMARY KEY,
    NombreArchivo NVARCHAR(255) NOT NULL,
    RutaArchivo NVARCHAR(500) NOT NULL,
    TipoContenido NVARCHAR(100),
    CodigoCita INT NOT NULL,

    CONSTRAINT FK_Anexo_Cita FOREIGN KEY (CodigoCita) REFERENCES Cita(CodigoCita) ON DELETE CASCADE
);
CREATE TABLE Medicamento (
    CodigoMedicamento INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100),
    Descripcion NVARCHAR(200)
);
CREATE TABLE ConsultaMedicamento (
    Codigo INT PRIMARY KEY IDENTITY(1,1),
    CodigoCita INT NOT NULL,
    CodigoMedicamento INT NOT NULL,
    Dosis NVARCHAR(100),
    Frecuencia NVARCHAR(100),
    Duracion NVARCHAR(100),
    FOREIGN KEY (CodigoCita) REFERENCES Cita(CodigoCita),
    FOREIGN KEY (CodigoMedicamento) REFERENCES Medicamento(CodigoMedicamento)
);