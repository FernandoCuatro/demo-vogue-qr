CREATE DATABASE vogue_QR

-- Creación de la tabla vt_usuarios_tipo
CREATE TABLE vt_usuarios_tipo (
    tipo_usuario_id SERIAL PRIMARY KEY,
    tipo_usuario VARCHAR(50) NOT NULL,
    tipo_descripcion TEXT,
    tipo_fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla vt_usuarios
CREATE TABLE vt_usuarios (
    usuario_id SERIAL PRIMARY KEY,
    usuario_nombres VARCHAR(50) NOT NULL,
    usuario_apellidos VARCHAR(50) NOT NULL,
    usuario_correo VARCHAR(150) NOT NULL UNIQUE,
    usuario_contrasenia VARCHAR(255) NOT NULL,
    usuario_fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_usuario_id INT NOT NULL,
    CONSTRAINT fk_tipo_usuario FOREIGN KEY (tipo_usuario_id) REFERENCES vt_usuarios_tipo (tipo_usuario_id)
);

-- Creación de la tabla vt_permisos
CREATE TABLE vt_permisos (
    permiso_id SERIAL PRIMARY KEY,
    permiso_nombre VARCHAR(100) NOT NULL,
    permiso_descripcion TEXT,
    permiso_fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla vt_usuario_permisos
CREATE TABLE vt_usuario_permisos (
    usuario_permiso_id SERIAL PRIMARY KEY,
    permiso_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_permiso FOREIGN KEY (permiso_id) REFERENCES vt_permisos (permiso_id),
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_id) REFERENCES vt_usuarios (usuario_id)
);

-- Creación de la tabla inv_estatus_pre_emp
CREATE TABLE inv_estatus_pre_emp (
    estatus_pro_id SERIAL PRIMARY KEY,
    estatus_tipo VARCHAR(10) NOT NULL,
    estatus_descripcion TEXT,
    estatus_fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla in_preparador_empaquetado
CREATE TABLE in_preparador_empaquetado (
    proceso_id SERIAL PRIMARY KEY,
    fac_encabezado_id INT NOT NULL,
    preparacion_fecha DATE NOT NULL,
    preparacion_inicio TIME NOT NULL,
    preparacion_fin TIME NOT NULL,
    preparacion_usuario_id VARCHAR(10) NOT NULL,
    empaquetado_fecha DATE NOT NULL,
    empaquetado_inicio TIME NOT NULL,
    empaquetado_fin TIME NOT NULL,
    empaquetado_usuario_id VARCHAR(10) NOT NULL,
    estatus_pro_id INT NOT NULL,
    CONSTRAINT fk_estatus_pro FOREIGN KEY (estatus_pro_id) REFERENCES inv_estatus_pre_emp (estatus_pro_id)
);

-- Creación de la tabla fac_tipo
CREATE TABLE fac_tipo (
    fac_tipo_id SERIAL PRIMARY KEY,
    fac_tipo VARCHAR(50) NOT NULL,
    fac_tipo_descripcion TEXT,
    fac_tipo_fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla fac_encabezado
CREATE TABLE fac_encabezado (
    fac_encabezado_id SERIAL PRIMARY KEY,
    factura_no VARCHAR(15) NOT NULL UNIQUE,
    fac_tipo_id INT NOT NULL,
    fac_fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fac_total DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_fac_tipo FOREIGN KEY (fac_tipo_id) REFERENCES fac_tipo (fac_tipo_id)
);

-- Creación de la tabla fac_detalle
CREATE TABLE fac_detalle (
    fac_detalle_id SERIAL PRIMARY KEY,
    fac_encabezado_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_fac_encabezado FOREIGN KEY (fac_encabezado_id) REFERENCES fac_encabezado (fac_encabezado_id)
);
