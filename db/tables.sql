CREATE DATABASE prueba;

USE prueba;

DROP TABLE inventarios;
DROP TABLE productos;
DROP TABLE historiales;
DROP TABLE bodegas;
DROP TABLE users;


CREATE TABLE inventarios(
    `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `id_bodega` BIGINT(20) NOT NULL,
    `id_producto` BIGINT(20) NOT NULL,
    `cantidad` INT(11) NOT NULL,
    `create_by` BIGINT(20) NULL DEFAULT NULL,
    `update_by` BIGINT(20) NULL DEFAULT NULL,
    `create_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `update_at` TIMESTAMP NULL DEFAULT NULL,
    `delete_at` TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE productos(
    `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `nombre` VARCHAR(255) NOT NULL,
    `descripcion` VARCHAR(255) NOT NULL,
    `estado` TINYINT(4),
    `create_by` BIGINT(20) NULL DEFAULT NULL,
    `update_by` BIGINT(20) NULL DEFAULT NULL,
    `create_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `update_at` TIMESTAMP NULL DEFAULT NULL,
    `delete_at` TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE historiales(
    `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `cantidad` INT(11) NOT NULL,
    `id_bodega_origen` BIGINT(20) NOT NULL,
    `id_bodega_destino` BIGINT(20) NOT NULL,
    `id_inventario` BIGINT(20) NOT NULL,
    `create_by` BIGINT(20) NULL DEFAULT NULL,
    `update_by` BIGINT(20) NULL DEFAULT NULL,
    `create_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `update_at` TIMESTAMP NULL DEFAULT NULL,
    `delete_at` TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE bodegas(
    `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `nombre` VARCHAR(255) NOT NULL,
    `id_responsable` BIGINT(20) NOT NULL,
    `estado` TINYINT(4),
    `create_by` BIGINT(20) NULL DEFAULT NULL,
    `update_by` BIGINT(20) NULL DEFAULT NULL,
    `create_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `update_at` TIMESTAMP NULL DEFAULT NULL,
    `delete_at` TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE users(
    `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `nombre` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `email_verified_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `estado` TINYINT(4),
    `foto` VARCHAR(255) NULL DEFAULT NULL,
    `password` VARCHAR(255) NOT NULL,
    `create_by` BIGINT(20) NULL DEFAULT NULL,
    `update_by` BIGINT(20) NULL DEFAULT NULL,
    `create_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `update_at` TIMESTAMP NULL DEFAULT NULL,
    `delete_at` TIMESTAMP NULL DEFAULT NULL
);


ALTER TABLE inventarios 
    ADD UNIQUE KEY `id_bodega` (`id_bodega`, `id_producto`),
    ADD KEY `inventarios_create_by` (`create_by`),
    ADD KEY `inventarios_update_by` (`update_by`);

ALTER TABLE historiales
    ADD KEY `id_bodega` (`id_bodega_origen`, `id_bodega_destino`),
    ADD KEY `historiales_id_inventario` (`id_inventario`),
    ADD KEY `historiales_create_by` (`create_by`),
    ADD KEY `historiales_update_by` (`update_by`);

ALTER TABLE bodegas 
    ADD KEY `bodegas_id_responsable` (`id_responsable`),
    ADD KEY `bodegas_create_by` (`create_by`),
    ADD KEY `bodegas_update_by` (`update_by`);

ALTER TABLE productos 
    ADD KEY `productos_create_by` (`create_by`),
    ADD KEY `productos_update_by` (`update_by`);

-- Constraints for tables

ALTER TABLE inventarios
    ADD CONSTRAINT `inventarios_id_bodega` FOREIGN KEY (`id_bodega`) REFERENCES `bodegas`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `inventarios_id_PRODUCTO` FOREIGN KEY (`id_PRODUCTO`) REFERENCES `productos`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `inventarios_create_by` FOREIGN KEY (`create_by`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `inventarios_update_by` FOREIGN KEY (`update_by`) REFERENCES `users`(`id`) ON DELETE CASCADE;

ALTER TABLE productos
    ADD CONSTRAINT `productos_create_by` FOREIGN KEY (`create_by`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `productos_update_by` FOREIGN KEY (`update_by`) REFERENCES `users`(`id`) ON DELETE CASCADE;

ALTER TABLE historiales
    ADD CONSTRAINT `historiales_id_bodega_origen` FOREIGN KEY (`id_bodega_origen`) REFERENCES `bodegas`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `historiales_id_bodega_destino` FOREIGN KEY (`id_bodega_destino`) REFERENCES `bodegas`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `historiales_id_inventario` FOREIGN KEY (`id_inventario`) REFERENCES `inventarios`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `historiales_create_by` FOREIGN KEY (`create_by`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `historiales_update_by` FOREIGN KEY (`update_by`) REFERENCES `users`(`id`) ON DELETE CASCADE;

ALTER TABLE bodegas
    ADD CONSTRAINT `bodegas_id_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `bodegas_create_by` FOREIGN KEY (`create_by`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    ADD CONSTRAINT `bodegas_update_by` FOREIGN KEY (`update_by`) REFERENCES `users`(`id`) ON DELETE CASCADE;
